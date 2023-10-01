import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vege/src/mange%20inventory/domin/models/vegetable.dart';

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
      await db.execute("CREATE TABLE vegetable ("
          "id integer primary key AUTOINCREMENT,"
          "name TEXT,"
          "code TEXT"
          "sale_price TEXT"
          "buy_price TEXT"
          "catagory_id TEXT"
          "type TEXT"
          "image TEXT"
          "user_id TEXT"//foreign key
          ")");
    });
  }

  addvegetableToDatabase(Vegetable person) async {
    final db = await database;
    var raw = await db.insert(
      "vegetable",
      person.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updateVegetable(Vegetable person) async {
    final db = await database;
    var response = await db.update("vegetable", person.toMap(),
        where: "id = ?", whereArgs: [person.id]);
    return response;
  }

  Future<Vegetable?>? getVegetableWithId(int id) async {
    final db = await database;
    var response = await db.query("vegetable", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? Vegetable.fromMap(response.first) : null;
  }

  Future<List<Vegetable>> getAllPersons() async {
    final db = await database;
    var response = await db.query("vegetable");
    List<Vegetable> list = response.map((c) => Vegetable.fromMap(c)).toList();
    return list;
  }

  deletePersonWithId(int id) async {
    final db = await database;
    return db.delete("vegetable", where: "id = ?", whereArgs: [id]);
  }

  deleteAllPersons() async {
    final db = await database;
    db.delete("vegetable");
  }
}