import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vege/src/mange%20users/domin/models/user.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
late  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "vege.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE user ("
          "id integer primary key AUTOINCREMENT,"
          "first_name TEXT,"
          "last_name TEXT"
          "password TEXT"
          "phone_number TEXT"
          "position TEXT"
          "email TEXT"
          "account_state TEXT"
          ")");
    });
  }

  addUserToDatabase(User person) async {
    final db = await database;
    var raw = await db.insert(
      "user",
      person.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updateUser(User person) async {
    final db = await database;
    var response = await db.update("user", person.toMap(),
        where: "id = ?", whereArgs: [person.id]);
    return response;
  }

  Future<User?>? getUserWithId(int id) async {
    final db = await database;
    var response = await db.query("user", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? User.fromMap(response.first) : null;
  }

  Future<List<User>> getAllUser() async {
    final db = await database;
    var response = await db.query("user");
    List<User> list = response.map((c) => User.fromMap(c)).toList();
    return list;
  }

  deleteUserWithId(int id) async {
    final db = await database;
    return db.delete("user", where: "id = ?", whereArgs: [id]);
  }

  deleteAllusers() async {
    final db = await database;
    db.delete("user");
  }
}