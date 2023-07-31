import 'package:flutter/material.dart';
import 'package:notes/constants.dart';
import 'package:notes/models/notes.dart';
import 'package:notes/widgets/mini_button.dart';
import '../database/notes_database.dart';

class AddNotesPage extends StatefulWidget {
  final Note? note;
  const AddNotesPage({Key? key, this.note}) : super(key: key);

  @override
  State<AddNotesPage> createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  late String title;

  late String description;

  Future addNotes() async {
    final tempNote = Note(
      title: title.trim(),
      description: description.trim(),
      createdTime: DateTime.now(),
      isImportant: false,
    );
    return await NotesDatabase.instance.insert(tempNote);
  }

  Future updateNotes() async {
    final tempNote = widget.note?.copy(
      title: title.trim(),
      description: description.trim(),
      isImportant: false,
    );
    return await NotesDatabase.instance.update(tempNote!);
  }

  Future addOrUpdateNotes() async {
    if (widget.note == null) {
      return await addNotes();
    } else {
      return await updateNotes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onTap: () {
              addOrUpdateNotes();
              Navigator.pop(context);
            },
            child: const MiniButton(
              icon: Icons.check,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 40),
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) => setState(() => title = value),
                initialValue: widget.note == null ? '' : widget.note?.title,
                style: kTextStyleTitle,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    fontSize: 35,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) => setState(() => description = value),
                initialValue:
                    widget.note == null ? '' : widget.note?.description,
                maxLines: 1000,
                textCapitalization: TextCapitalization.sentences,
                style: kTextStyleDescription,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Description',
                  hintStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
