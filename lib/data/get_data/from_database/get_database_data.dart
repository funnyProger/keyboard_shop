import 'package:keyboard_shop/constants/constants.dart';
import 'package:keyboard_shop/data/controllers/database_controller.dart';
import 'package:keyboard_shop/data/get_data/shared_preferences/shared_preferences_data.dart';
import 'package:keyboard_shop/data/model_objects/cart/cart_product.dart';
import 'package:keyboard_shop/data/model_objects/database/database_entity.dart';
import 'package:keyboard_shop/data/model_objects/favorite/favorite_product.dart';
import 'package:keyboard_shop/data/model_objects/product/base_product.dart';
import 'package:keyboard_shop/data/model_objects/user/new_user.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        await db.execute(Constants.createCartTableSQL);
        await db.execute(Constants.createFavoritesTableSQL);
        await db.execute(Constants.createUsersTableSQL);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if(oldVersion < 1) {
          await db.execute(Constants.createUsersTableSQL);
        }
      },
    );
    return database;
  }


  @override
  Future<void> insetIntoTable(DbEntity object, String tableName) async {
    final db = await database;

    await db.insert(
      tableName,
      object.toJson(),
    );
  }


  @override
  Future<List<Object>> getAllDataFormTable(String tableName) async {
    SharedPreferences sharPref = await SharedPreferencesData().sharedPreferences;
    String? userId =  sharPref.getString('currentUserName');

    final db = await database;
    final dataObjects = await db.rawQuery("select * from $tableName where userId = ?", [userId]);

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
  Future<void> deleteDataFromTable(String productName, String tableName) async {
    SharedPreferences sharPref = await SharedPreferencesData().sharedPreferences;
    String? userId =  sharPref.getString('currentUserName');

    final db = await database;
    await db.delete(
      tableName,
      where: 'name = ? and userId = ?',
      whereArgs: [productName, userId]
    );
  }


  @override
  Future<void> deleteAllDataFromTable(String tableName) async {
    SharedPreferences sharPref = await SharedPreferencesData().sharedPreferences;
    String userId =  sharPref.getString('currentUserName') ?? '';

    final db = await database;
    await db.delete(
      tableName,
      where: 'userId = ?',
      whereArgs: [userId]
    );
  }


  @override
  Future<void> updateDataInTableByName(BaseProduct object, String tableName) async {
    SharedPreferences sharPref = await SharedPreferencesData().sharedPreferences;
    String userId =  sharPref.getString('currentUserName') ?? '';

    final db = await database;
    await db.update(
      tableName,
      object.toJson(),
      where: 'name = ? and userId = ?',
      whereArgs: [object.name, userId]
    );
  }


  @override
  Future<int> getDataBaseTableCount(String tableName) async {
    SharedPreferences sharPref = await SharedPreferencesData().sharedPreferences;
    String? userId =  sharPref.getString('currentUserName');

    final db = await database;

    int? count = Sqflite.firstIntValue(await db.rawQuery("select sum(count) from $tableName where userId = ?", [userId]));
    return  count ?? 0;
  }


  @override
  Future<List<NewUser>> getUserByNameOrPhoneNumber(String userName, String phoneNumber) async {
    final db = await database;
    String sqlQuery = "select * from users where phoneNumber = '$phoneNumber' or name = '$userName'";
    final dataObjects = await db.rawQuery(sqlQuery);

    return dataObjects.map((user) => NewUser.fromJson(user)).toList();
  }


  @override
  Future<NewUser?> getUserByPasswordAndPhoneNumber(String password, String phoneNumber) async {
    final db = await database;
    String sqlQuery = "select * from users where phoneNumber = '$phoneNumber' and password = '$password'";
    final dataObjects = await db.rawQuery(sqlQuery);
    List<NewUser> list = dataObjects.map((user) => NewUser.fromJson(user)).toList();
    NewUser? userData = list.isEmpty ? null : list.single;
    return userData;
  }


  @override
  Future<List<int>?> getCurrentUserImage(String currentUserName) async {
    final db = await database;
    String sqlQuery = "select * from users where name = $currentUserName";
    final dataObjects = await db.rawQuery(sqlQuery);
    List<NewUser> list = dataObjects.map((user) => NewUser.fromJson(user)).toList();
    NewUser? userData = list.isEmpty ? null : list.single;

    return userData?.image;
  }
}