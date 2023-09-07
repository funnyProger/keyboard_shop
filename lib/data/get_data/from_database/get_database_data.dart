import 'package:keyboard_shop/data/controllers/database_controller.dart';
import 'package:keyboard_shop/data/model_objects/basket_product.dart';
import 'package:keyboard_shop/data/model_objects/favorite_product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class GetDataFromDatabase implements GetDataFromDatabaseInterface {
  Database? _database;


  Future<Database> get database async {
    if(_database != null) {
      return _database!;
    } else {
      _database = await initDatabase();
      return _database!;
    }
  }


  @override
  Future<Database> initDatabase() async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'keyboard_shop.db'),
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute(
            '''create table if not exists basket (
            id integer primary key, 
            image text,
            name text,
            price integer,
            count integer
            )'''
        );
        await db.execute(
            '''create table if not exists favorites (
            id integer primary key, 
            image text,
            name text,
            price integer,
            description text
            )'''
        );
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if(oldVersion < newVersion) {
          await db.execute(
              '''create table if not exists favorites (
              id integer primary key, 
              image text,
              name text,
              price integer,
              description text
              )'''
          );
        }
      },
    );
    return database;
  }


  @override
  Future<void> insetIntoTable(Object object, String tableName) async {
    var objectProduct;

    if(tableName == 'basket') {
      objectProduct = object as BasketProduct;
    } else if(tableName == 'favorites') {
      objectProduct = object as FavoriteProduct;
    }

    final db = await database;
    await db.insert(
      tableName,
      objectProduct.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  @override
  Future<List<Object>> getAllDataFormTable(String tableName) async {
    final db = await database;
    final products = await db.rawQuery('select * from $tableName');

    if(tableName == 'basket') {
      return products.map((product) => BasketProduct.fromJson(product)).toList();
    } else if(tableName == 'favorites') {
      return products.map((product) => FavoriteProduct.fromJson(product)).toList();
    } else {
      return [] as List<Object>;
    }
  }


  @override
  Future<void> deleteDataFromTable(int id, String tableName) async {
    final db = await database;
    await db.rawDelete('delete from $tableName where id = ?', [id]);
  }


  @override
  Future<void> deleteAllDataFromTable(String tableName) async {
    final db = await database;
    await db.rawDelete('delete from $tableName');
  }


  @override
  Future<void> updateDataInTable(Object object, String tableName) async {
    var objectProduct;

    if(tableName == 'basket') {
      objectProduct = object as BasketProduct;
    } else if(tableName == 'favorites') {
      objectProduct = object as FavoriteProduct;
    }

    final db = await database;
    await db.update(
        tableName,
        objectProduct.toJson(),
        where: 'id = ?',
        whereArgs: [objectProduct.id]
    );
  }


  @override
  Future<int> getDataBaseTableCount(String tableName) async {
    final db = await database;
    int? count = Sqflite.firstIntValue(await db.rawQuery('select sum(count) from $tableName'));

    if(count == null) {
      return (count = 0);
    } else {
      return count;
    }
  }
}
