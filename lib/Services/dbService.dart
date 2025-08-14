import 'package:flutter_application_1_1/Models/cartModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class Db_service {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }

    // Delete the existing database
    await deleteDatabase();

    _db = await initDatabase();
    return _db;
  }

  Future<void> deleteDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cart.db');
    await deleteDatabaseFile(path);
  }

  Future<void> deleteDatabaseFile(String path) async {
    if (await io.File(path).exists()) {
      await io.File(path).delete();
    }
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cart.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE cart (id INTEGER PRIMARY KEY, productId TEXT UNIQUE, productName TEXT, initialPrice DOUBLE, productPrice DOUBLE, currentStock INTEGER, quantity INTEGER DEFAULT 0, unitTag TEXT, image TEXT)'
    );
  }

  Future<Cart> insert(Cart cart) async {
    var dbClient = await db;
    await dbClient!.insert('cart', cart.toMap());
    return cart;
  }

  Future<List<Cart>> getCartList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('cart');
    return queryResult.map((e) => Cart.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('cart',
    where: 'id = ?',
    whereArgs: [id]
    );
  }

  Future<int> updateQauntity(Cart cart) async {
    var dbClient = await db;
    return await dbClient!.update('cart',
    cart.toMap(),
    where: 'id = ?',
    whereArgs: [cart.id]
    );
  }
}