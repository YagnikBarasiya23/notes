import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../models/notes.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({Key? key, required this.notes, required this.index})
      : super(key: key);
  static List<Color> colors = [
    Colors.blue.shade800,
    Colors.red.shade800,
    Colors.yellow.shade800,
    Colors.brown.shade800,
    Colors.green.shade800,
    Colors.pink.shade800,
    Colors.orange.shade800,
  ];
  final List<Note> notes;
  final int index;
  @override
  Widget build(BuildContext context) {
    colors.shuffle();
    return Card(
      color: colors[index % notes.length],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notes[index].title!,
              style: kTextStyleTitle.copyWith(fontSize: 25),
            ),
            const SizedBox(height: 10),
            Text(
              DateFormat.yMMMd().format(notes[index].createdTime!),
              style: kTextStyleTime,
            ),
          ],
        ),
      ),
    );
  }
}
