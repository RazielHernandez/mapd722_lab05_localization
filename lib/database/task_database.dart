import 'dart:async';
import 'package:mapd722_todo_carlos_hernandez/objects/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class taskDatabase {

  /*get database => null;
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'tasks_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id TEXT PRIMARY KEY, title TEXT, description TEXT, category TEXT, status INTEGER)',
        );
      },
      version: 1,
    );
  }*/

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'tasks.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE tasks(id TEXT PRIMARY KEY, title TEXT, description TEXT, category TEXT, status INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<void> saveTask(Task task) async {
    final db = await initializeDB();

    await db.insert(
      'dogs',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  } 

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Task>> tasks() async {
    // Get a reference to the database.
    final db = await initializeDB();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        category: maps[i]['category'],
        isDone: maps[i]['status'],
      );
    });
  }

  Future<void> updateTask(Task task) async {
    // Get a reference to the database.
    final db = await initializeDB();

    // Update the given Dog.
    await db.update(
      'tasks',
      task.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [task.id],
    );
  }

}