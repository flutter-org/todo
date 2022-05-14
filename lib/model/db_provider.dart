// ignore_for_file: constant_identifier_names

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo/model/todo.dart';

const String DB_NAME = 'todo_list.db';
const String TABLE_NAME = 'todo_list';
const String CREATE_TABLE_SQL = '''
create table $TABLE_NAME (
  $ID text primary key,
  $TITLE text,
  $DESCRIPTION text,
  $DATE text,
  $START_TIME text,
  $END_TIME text,
  $PRIORITY integer,
  $IS_FINISHED integer,
  $IS_STAR integer,
  $LOCATION_LATITUDE text,
  $LOCATION_LONGITUDE text,
  $LOCATION_DESCRIPTION text 
)
''';

class DbProvider {
  final String _dbKey;
  Database? _database;

  DbProvider(this._dbKey);

  Future<void> _initDataBase() async {
    _database ??= await openDatabase(
      '$_dbKey\_$DB_NAME',
      version: 1,
      onCreate: (Database database, int version) async {
        await database.execute(CREATE_TABLE_SQL);
      },
    );
  }

  Future<List<Todo>> loadFromDataBase() async {
    await _initDataBase();
    List<Map<String, dynamic>> dbRecords = await _database!.query(TABLE_NAME);
    return dbRecords.map((item) => Todo.fromMap(item)).toList();
  }

  Future<int> add(Todo todo) async {
    return _database!.insert(
      TABLE_NAME,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> remove(Todo todo) async {
    return _database!.delete(
      TABLE_NAME,
      where: '$ID = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> update(Todo todo) async {
    return _database!.update(
      TABLE_NAME,
      todo.toMap(),
      where: '$ID = ?',
      whereArgs: [todo.id],
    );
  }
}
