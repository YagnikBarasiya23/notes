import 'package:flutter/material.dart';
import 'package:notes/constants.dart';
import 'package:notes/database/notes_database.dart';
import 'package:notes/pages/add_notes_page.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../models/notes.dart';
import '../widgets/mini_button.dart';
import '../widgets/note_tile.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Note> notes = [];
  bool isLoading = false;

  Future refreshAllNotes() async {
    setState(() => isLoading = true);
    notes = await NotesDatabase.instance.readAllNotes();
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    refreshAllNotes();
    super.initState();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        List<Note> tempNotes = [];
        tempNotes = await NotesDatabase.instance.readAllNotes();
        setState(() => notes = tempNotes);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Notes', style: TextStyle(fontSize: 35)),
          ),
          actions: const [
            MiniButton(
              icon: Icons.search,
            ),
          ],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : notes.isEmpty
                ? const Center(
                    child: Text(
                      'No Notes',
                      style: kTextStyleTitle,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: 4,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/noteDetails',
                          arguments: notes[index].id,
                        ),
                        child: NoteTile(
                          index: index,
                          notes: notes,
                        ),
                      ),
                      staggeredTileBuilder: (index) =>
                          const StaggeredTile.fit(2),
                      itemCount: notes.length,
                    ),
                  ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNotesPage(),
            ),
          ),
          child: const Icon(
            Icons.add,
            size: 25,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
