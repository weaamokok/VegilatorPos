import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vege/src/mange%20inventory/domin/models/vegetable.dart';
import 'package:vege/src/utils/constants.dart';

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
            await db.execute("CREATE TABLE ${AppConst.position} ("
          "${AppConst.id} integer primary key AUTOINCREMENT,"
          "${AppConst.title} TEXT,"
        
          ")");    
            await db.execute("CREATE TABLE ${AppConst.user} ("
          "${AppConst.id} integer primary key AUTOINCREMENT,"
          "${AppConst.firstName} TEXT,"
          "${AppConst.lastName} TEXT"
          "${AppConst.password} TEXT"
          "${AppConst.phoneNumber} TEXT"
          "${AppConst.positionId} TEXT"
          "${AppConst.email} TEXT"
          "${AppConst.accountState} TEXT"
          "FOREIGN KEY(${AppConst.positionId}) REFERENCES ${AppConst.position}(${AppConst.id})"//foreign key

          ")");

      await db.execute("CREATE TABLE ${AppConst.catagory} ("
          "${AppConst.id} integer primary key AUTOINCREMENT,"
          "${AppConst.catagory} TEXT,"

          ")"); 
           await db.execute("CREATE TABLE ${AppConst.vegetable} ("
          "${AppConst.id} integer primary key AUTOINCREMENT,"
          "${AppConst.name} TEXT,"
          "${AppConst.code} TEXT"
          "${AppConst.salePrice} REAL"
          "${AppConst.buyPrice} REAL"
          "${AppConst.catagoryId} integer"
          "${AppConst.image} TEXT"
          "${AppConst.userId} integer"
          "FOREIGN KEY(${AppConst.userId}) REFERENCES ${AppConst.user}(${AppConst.id})"//foreign key
          "FOREIGN KEY(${AppConst.catagoryId}) REFERENCES ${AppConst.catagory}(${AppConst.id})"//foreign key
          ")");   
          
          await db.execute("CREATE TABLE ${AppConst.invoice} ("
          "${AppConst.id} integer primary key AUTOINCREMENT,"
          "${AppConst.totalAmount} REAL"
          "${AppConst.dateRecorded} TEXT"
          "${AppConst.paymentType} TEXT"
          "${AppConst.userId} integer"
          "FOREIGN KEY(${AppConst.userId}) REFERENCES ${AppConst.user}(${AppConst.id})"//foreign key
          ")"); 
           await db.execute("CREATE TABLE ${AppConst.sale} ("
          "${AppConst.id} integer primary key AUTOINCREMENT,"
          "${AppConst.subTotal} REAL"
          "${AppConst.unitPrice} REAL"
          "${AppConst.vegeId} integer"
          "${AppConst.invoiceId} integer"
          "${AppConst.quantity} integer"
          "FOREIGN KEY(${AppConst.invoiceId}) REFERENCES ${AppConst.invoice}(${AppConst.id})"//foreign key
          "FOREIGN KEY(${AppConst.vegeId}) REFERENCES ${AppConst.vegetable}(${AppConst.id})"//foreign key
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