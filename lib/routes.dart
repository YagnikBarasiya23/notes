import 'package:flutter/material.dart';
import 'package:notes/pages/add_notes_page.dart';
import 'package:notes/pages/note_details_page.dart';
import 'package:notes/pages/notes_page.dart';
import 'models/notes.dart';

class RouteHelper {
  static Route generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const NotesPage(),
        );
      case '/addNotes':
        Note note = settings.arguments as Note;
        return MaterialPageRoute(
          builder: (context) => AddNotesPage(note: note),
        );
      case '/noteDetails':
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => NoteDetailsPage(
            id: id,
          ),
        );
    }
    return MaterialPageRoute(
      builder: (context) => const Scaffold(),
    );
  }
}
