import 'package:keyboard_shop/data/controllers/database_controller.dart';
import 'package:keyboard_shop/data/model_objects/cart/cart_product.dart';
import 'package:keyboard_shop/data/model_objects/favorite/favorite_product.dart';
import 'package:keyboard_shop/data/model_objects/user/new_user.dart';
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
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            '''create table if not exists cart (
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
        await db.execute(
            '''create table if not exists users (
              id integer primary key autoincrement, 
              image text,
              name text,
              phoneNumber text,
              password text
              )'''
        );
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if(oldVersion < newVersion) {
          await db.execute(
              '''create table if not exists users (
              id integer primary key autoincrement, 
              image text,
              name text,
              phoneNumber text,
              password text
              )'''
          );
        }
      },
    );
    return database;
  }


  @override
  Future<void> insetIntoTable(Object object, String tableName) async {
    var dataObject;

    if(tableName == 'cart') {
      dataObject = object as CartProduct;
    } else if(tableName == 'favorites') {
      dataObject = object as FavoriteProduct;
    } else if(tableName == 'users') {
      dataObject = object as NewUser;
    }

    final db = await database;
    await db.insert(
      tableName,
      dataObject.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  @override
  Future<List<Object>> getAllDataFormTable(String tableName) async {
    final db = await database;
    final dataObjects = await db.rawQuery('select * from $tableName');

    if(tableName == 'cart') {
      return dataObjects.map((product) => CartProduct.fromJson(product)).toList();
    } else if(tableName == 'favorites') {
      return dataObjects.map((product) => FavoriteProduct.fromJson(product)).toList();
    } else if(tableName == 'users') {
      return dataObjects.map((user) => NewUser.fromJson(user)).toList();
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
    var dataObject;

    if(tableName == 'cart') {
      dataObject = object as CartProduct;
    } else if(tableName == 'favorites') {
      dataObject = object as FavoriteProduct;
    } else if(tableName == 'users') {
      dataObject = object as NewUser;
    }

    final db = await database;
    await db.update(
        tableName,
        dataObject.toJson(),
        where: 'id = ?',
        whereArgs: [dataObject.id]
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


  @override
  Future<List<NewUser>> getUserByName(String userName) async {
    final db = await database;
    String sqlQuery = "select * from users where name = '$userName'";
    final dataObjects = await db.rawQuery(sqlQuery);
    if(dataObjects.isEmpty) {
      return [];
    } else {
      return dataObjects.map((user) => NewUser.fromJson(user)).toList();
    }
  }
}
