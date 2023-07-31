import 'package:flutter/material.dart';
import 'package:notes/database/notes_database.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../models/notes.dart';
import '../widgets/mini_button.dart';

class NoteDetailsPage extends StatefulWidget {
  const NoteDetailsPage({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<NoteDetailsPage> createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage> {
  Note? note;

  bool isLoading = false;

  Future refreshNote() async {
    setState(() => isLoading = true);
    note = await NotesDatabase.instance.read(widget.id);
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    refreshNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Note tempNote;
        tempNote = await NotesDatabase.instance.read(widget.id);
        setState(() => note = tempNote);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: InkWell(
            onTap: () => Navigator.pop(context),
            child: const MiniButton(
              icon: Icons.arrow_back,
            ),
          ),
          actions: [
            InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, '/addNotes', arguments: note),
              child: const MiniButton(
                icon: Icons.edit,
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                NotesDatabase.instance.delete(widget.id);
                Navigator.pop(context);
              },
              child: const MiniButton(
                icon: Icons.delete,
              ),
            ),
          ],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : note == null
                ? const Center(
                    child: Text(
                      'Something went wrong',
                      style: kTextStyleTitle,
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            note!.title!,
                            style: kTextStyleTitle,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            DateFormat.yMMMd().format(note!.createdTime!),
                            style: kTextStyleTime,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            note!.description!,
                            style: kTextStyleDescription,
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
