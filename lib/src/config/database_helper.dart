import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vege/src/manage%20purchases/domin/model/invoice.dart';
import 'package:vege/src/manage%20purchases/domin/model/sale.dart';
import 'package:vege/src/mange%20inventory/domin/models/vegetable.dart';
import 'package:vege/src/mange%20users/domin/models/position.dart';
import 'package:vege/src/mange%20users/domin/models/user.dart';
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
    return await openDatabase(path, version: 1,   onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
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
          "${AppConst.code} integer"
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
/////inventory manage
  addvegetableToDatabase(Vegetable vege) async {
    final db = await database;
    var raw = await db.insert(
      AppConst.vegetable,
      vege.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updateVegetable(Vegetable vege) async {
    final db = await database;
    var response = await db.update(AppConst.vegetable, vege.toMap(),
        where: "id = ?", whereArgs: [vege.id]);
    return response;
  }

  Future<Vegetable?>? getVegetableWithId(int id) async {
    final db = await database;
    var response = await db.query(AppConst.vegetable, where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? Vegetable.fromMap(response.first) : null;
  }

  Future<List<Vegetable>> getAllVeges() async {
    final db = await database;
    var response = await db.query(AppConst.vegetable);
    List<Vegetable> list = response.map((c) => Vegetable.fromMap(c)).toList();
    return list;
  }

  deleteVegetableWithId(int id) async {
    final db = await database;
    return db.delete(AppConst.vegetable, where: "id = ?", whereArgs: [id]);
  }

  deleteAllVegetable() async {
    final db = await database;
    db.delete(AppConst.vegetable);
  }
  //manage purchases>>invoice
   addInvoiceToDatabase(Invoice invoice) async {
    final db = await database;
    var raw = await db.insert(
      AppConst.invoice,
      invoice.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updateInvoice(Invoice invoice) async {
    final db = await database;
    var response = await db.update(AppConst.invoice, invoice.toMap(),
        where: "${AppConst.id} = ?", whereArgs: [invoice.id]);
    return response;
  }

  Future<Invoice?>? getInvoiceWithId(int id) async {
    final db = await database;
    var response = await db.query(AppConst.invoice, where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? Invoice.fromMap(response.first) : null;
  }

  Future<List<Invoice>> getAllInvoice() async {
    final db = await database;
    var response = await db.query(AppConst.invoice);
    List<Invoice> list = response.map((c) => Invoice.fromMap(c)).toList();
    return list;
  }

  deleteInvoiceWithId(int id) async {
    final db = await database;
    return db.delete(AppConst.invoice, where: "id = ?", whereArgs: [id]);
  }

  deleteAllInvoice() async {
    final db = await database;
    db.delete(AppConst.invoice);
  }
  //  //manage purchases>>sale
     addSaleToDatabase(Sale sale) async {
    final db = await database;
    var raw = await db.insert(
      AppConst.sale,
      sale.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updateSale(Sale sale) async {
    final db = await database;
    var response = await db.update(AppConst.sale, sale.toMap(),
        where: "${AppConst.id} = ?", whereArgs: [sale.id]);
    return response;
  }

  Future<Sale?>? getSaleWithId(int id) async {
    final db = await database;
    var response = await db.query(AppConst.sale, where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? Sale.fromMap(response.first) : null;
  }

  Future<List<Sale>> getAllSales() async {
    final db = await database;
    var response = await db.query(AppConst.sale);
    List<Sale> list = response.map((c) => Sale.fromMap(c)).toList();
    return list;
  }

  deleteSaleWithId(int id) async {
    final db = await database;
    return db.delete(AppConst.sale, where: "id = ?", whereArgs: [id]);
  }

  deleteAllSales() async {
    final db = await database;
    db.delete(AppConst.sale);
  }
  //mange users>>position
       addPositionToDatabase(Position sale) async {
    final db = await database;
    var raw = await db.insert(
      AppConst.position,
      sale.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updatePosition(Position position) async {
    final db = await database;
    var response = await db.update(AppConst.position, position.toMap(),
        where: "${AppConst.id} = ?", whereArgs: [position.id]);
    return response;
  }

  Future<Position?>? getPositionWithId(int id) async {
    final db = await database;
    var response = await db.query(AppConst.position, where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? Position.fromMap(response.first) : null;
  }

  Future<List<Position>> getAllPosition() async {
    final db = await database;
    var response = await db.query(AppConst.position);
    List<Position> list = response.map((c) => Position.fromMap(c)).toList();
    return list;
  }

  deletePositionWithId(int id) async {
    final db = await database;
    return db.delete(AppConst.position, where: "id = ?", whereArgs: [id]);
  }

  deleteAllPositions() async {
    final db = await database;
    db.delete(AppConst.position);
  } 
  //mange users>>user
       addUserToDatabase(User user) async {
    final db = await database;
    var raw = await db.insert(
      AppConst.user,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updateUser(User user) async {
    final db = await database;
    var response = await db.update(AppConst.user, user.toMap(),
        where: "${AppConst.id} = ?", whereArgs: [user.id]);
    return response;
  }

  Future<User?>? getUserWithId(int id) async {
    final db = await database;
    var response = await db.query(AppConst.user, where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? User.fromMap(response.first) : null;
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;
    var response = await db.query(AppConst.user);
    List<User> list = response.map((c) => User.fromMap(c)).toList();
    return list;
  }

  deleteUserWithId(int id) async {
    final db = await database;
    return db.delete(AppConst.user, where: "id = ?", whereArgs: [id]);
  }

  deleteAllUser() async {
    final db = await database;
    db.delete(AppConst.user);
  }

}