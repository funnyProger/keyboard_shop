import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_shop/core/model_objects/product_objects/product.dart';
import 'data_controller.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class GetData implements GetDataInterface {
  Database? _database;

  @override
  Future<List<Product>> getProductDataFromJson() async {
    try {
      final fileContent = await rootBundle.loadString('assets/product.json');
      final jsonData = json.decode(fileContent) as List<dynamic>;
      return  jsonData.map((element) => Product.fromJson(element)).toList();
    } catch(e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<Database> get database async {
    if(_database != null) {
      return _database!;
    } else {
      _database = await initBasketDataBase();
      return _database!;
    }
  }

  @override
  Future<Database> initBasketDataBase() async {
    var database = await openDatabase(
      join(await getDatabasesPath(), 'basket.db'),
      onCreate: createBasketTable,
      version: 1,
    );
    return database;
  }

  Future<void> createBasketTable(Database database, int version) async {
    return await database.execute(
        '''create table if not exists basket (
                id integer primary key, 
                image text,
                name text,
                price integer,
                description text,
                count integer
            )'''
    );
  }

  @override
  Future<void> insetIntoBasketDB(Product product) async {
    final db = await database;
    await db.insert(
      'basket',
      product.toSQLite(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Product>> getAllDataFormBasketDB() async {
    final db = await database;
    final products = await db.rawQuery('select * from basket');
    return products.map((product) => Product.fromSqfliteDatabase(product)).toList();
  }

  @override
  Future<void> deleteDataFromBasketDB(int id) async {
    final db = await database;
    await db.rawDelete('delete from basket where id = ?', [id]);
  }

  @override
  Future<void> deleteAllDataFromBasketDB() async {
    final db = await database;
    await db.rawDelete('delete from basket');
  }

  @override
  Future<void> updateDataInBasketDB(Product product) async {
    final db = await database;
    await db.update(
      "basket",
      product.toSQLite(),
      where: 'id = ?',
      whereArgs: [product.id]
    );
  }

  @override
  Future<int> getDataBaseTableCount() async {
    final db = await database;
    int? count = Sqflite.firstIntValue(await db.rawQuery('select sum(count) from basket'));
    if(count == null) {
      return (count = 0);
    } else {
      return count;
    }
  }

}