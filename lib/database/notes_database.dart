import 'package:notes/models/notes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/note_fields.dart';

const tableNotes = 'notes';

class NotesDatabase {
  NotesDatabase._init();

  static NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('note.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future _createTable(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const booleanType = 'BOOLEAN NOT NULL';

    try {
      await db.execute('''
    CREATE TABLE $tableNotes(
    ${NoteFields.id} $idType,
    ${NoteFields.title} $textType,
    ${NoteFields.description} $textType,
    ${NoteFields.isImportant} $booleanType,
    ${NoteFields.createdTime} $textType)
    ''');
    } catch (e) {
      print(e);
    }
    print('table created successfully');
  }

  Future<Note> insert(Note note) async {
    final db = await instance.database;
    final id = await db.insert(tableNotes, note.toJson());
    print(note.copy(id: id).toString());
    return note.copy(id: id);
  }

  Future<Note> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
    print(Note.fromJson(maps.first).toString());
    return Note.fromJson(maps.first);
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    final response = await db.query(tableNotes);
    print(response.map((e) => Note.fromJson(e)).toList().toString());
    return response.map((e) => Note.fromJson(e)).toList();
  }

  Future<int> update(Note note) async {
    final db = await instance.database;
    return await db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
