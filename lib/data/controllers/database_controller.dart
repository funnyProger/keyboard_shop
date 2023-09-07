import 'dart:async';
import 'package:keyboard_shop/data/get_data/from_database/get_database_data.dart';

abstract class GetDataFromDatabaseInterface {
  initDatabase();
  insetIntoTable(Object object, String tableName);
  getAllDataFormTable(String tableName);
  deleteDataFromTable(int id, String tableName);
  deleteAllDataFromTable(String tableName);
  updateDataInTable(Object object, String tableName);
  getDataBaseTableCount(String tableName);
}


class DatabaseController {
  final GetDataFromDatabaseInterface _dataObject = GetDataFromDatabase();


  void initDB() {
    _dataObject.initDatabase();
  }


  Future<List<Object>> getDataFromTable(String tableName) async {
    return await _dataObject.getAllDataFormTable(tableName);
  }


  void addDataToTable(Object object, String tableName) {
    _dataObject.insetIntoTable(object, tableName);
  }


  void deleteTableData(int id, String tableName) {
    _dataObject.deleteDataFromTable(id, tableName);
  }


  void deleteAllTableData(String tableName) {
    _dataObject.deleteAllDataFromTable(tableName);
  }


  void updateTableData(Object object, String tableName) {
    _dataObject.updateDataInTable(object, tableName);
  }


  Future<int> getTableCount(String tableName) {
    return _dataObject.getDataBaseTableCount(tableName);
  }
}
