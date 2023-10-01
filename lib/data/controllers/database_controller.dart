import 'dart:async';
import 'package:keyboard_shop/data/get_data/from_database/get_database_data.dart';
import 'package:keyboard_shop/data/model_objects/database/database_entity.dart';
import 'package:keyboard_shop/data/model_objects/product/base_product.dart';
import 'package:keyboard_shop/data/model_objects/user/new_user.dart';

abstract class GetDataFromDatabaseInterface {
  initDatabase();
  insetIntoTable(DbEntity object, String tableName);
  getAllDataFormTable(String tableName);
  deleteDataFromTable(String productName, String tableName);
  deleteAllDataFromTable(String tableName);
  updateDataInTableByName(BaseProduct object, String tableName);
  getDataBaseTableCount(String tableName);
  getUserByNameOrPhoneNumber(String userName, String phoneNumber);
  getUserByPasswordAndPhoneNumber(String userName, String phoneNumber);
  getCurrentUserImage(String currentUserName);
}


class DatabaseController {
  final GetDataFromDatabaseInterface _implementationObject = GetDataFromDatabase();

  
  void initDB() {
    _implementationObject.initDatabase();
  }


  Future<List<Object>> getDataFromTable(String tableName) async {
    return await _implementationObject.getAllDataFormTable(tableName);
  }


  void addDataToTable(DbEntity object, String tableName) {
    _implementationObject.insetIntoTable(object, tableName);
  }


  void deleteTableData(String productName, String tableName) {
    _implementationObject.deleteDataFromTable(productName, tableName);
  }


  void deleteAllTableData(String tableName) {
    _implementationObject.deleteAllDataFromTable(tableName);
  }


  void updateTableDataByName(BaseProduct object, String tableName) {
    _implementationObject.updateDataInTableByName(object, tableName);
  }


  Future<int> getTableCount(String tableName) async {
    return _implementationObject.getDataBaseTableCount(tableName);
  }


  Future<List<NewUser>> isDBContainUserWithThisNameOrPhoneNumber(String userName, String phoneNumber) async {
    return _implementationObject.getUserByNameOrPhoneNumber(userName, phoneNumber);
  }


  Future<NewUser?> isDBContainUserWithThisPasswordAndPhoneNumber(String password, String phoneNumber) async {
    return _implementationObject.getUserByPasswordAndPhoneNumber(password, phoneNumber);
  }


  Future<List<int>?> getCurrentUserImageFromDBbyName(String currentUserName) async {
    return _implementationObject.getCurrentUserImage(currentUserName);
  }
}