import 'dart:async';
import 'package:keyboard_shop/data/get_data/from_database/get_database_data.dart';
import 'package:keyboard_shop/data/model_objects/user/new_user.dart';

abstract class GetDataFromDatabaseInterface {
  initDatabase();
  insetIntoTable(Object object, String tableName);
  getAllDataFormTable(String tableName);
  deleteDataFromTable(int id, String tableName);
  deleteAllDataFromTable(String tableName);
  updateDataInTable(Object object, String tableName);
  getDataBaseTableCount(String tableName);
  getUserByName(String userName);
}


class DatabaseController {
  final GetDataFromDatabaseInterface _implementationObject = GetDataFromDatabase();

  
  void initDB() {
    _implementationObject.initDatabase();
  }


  Future<List<Object>> getDataFromTable(String tableName) async {
    return await _implementationObject.getAllDataFormTable(tableName);
  }


  void addDataToTable(Object object, String tableName) {
    _implementationObject.insetIntoTable(object, tableName);
  }


  void deleteTableData(int id, String tableName) {
    _implementationObject.deleteDataFromTable(id, tableName);
  }


  void deleteAllTableData(String tableName) {
    _implementationObject.deleteAllDataFromTable(tableName);
  }


  void updateTableData(Object object, String tableName) {
    _implementationObject.updateDataInTable(object, tableName);
  }


  Future<int> getTableCount(String tableName) async {
    return _implementationObject.getDataBaseTableCount(tableName);
  }

  Future<List<NewUser>> isDBContainUserWithThisName(String userName) async {
    return _implementationObject.getUserByName(userName);
  }
}
