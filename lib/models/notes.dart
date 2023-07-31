import 'note_fields.dart';

class Note {
  final int? id;
  final String? title;
  final String? description;
  final bool? isImportant;
  final DateTime? createdTime;

  const Note({
    this.title,
    this.createdTime,
    this.id,
    this.isImportant,
    this.description,
  });

  Note copy({
    int? id,
    String? title,
    String? description,
    bool? isImportant,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        createdTime: createdTime ?? this.createdTime,
        isImportant: isImportant ?? this.isImportant,
        description: description ?? this.description,
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.isImportant: isImportant! ? 1 : 0,
        NoteFields.createdTime: createdTime?.toIso8601String(),
      };

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        isImportant: json[NoteFields.isImportant] == 1,
        createdTime: DateTime.parse(json[NoteFields.createdTime] as String),
      );
}
