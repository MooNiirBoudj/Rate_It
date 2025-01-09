import 'package:sqflite/sqflite.dart';

import 'dbhelper.dart';

class DBBaseTable {
  var db_table = 'TABLE_NAME_MUST_OVERRIDE';

  Future<bool> insertRecord(Map<String, dynamic> data) async {
    try {
      final database = await DBHelper.getDatabase();
      database.insert(db_table, data,
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
    }
    return false;
  }

  Future<List<Map>> getRecords() async {
    try {
      final database = await DBHelper.getDatabase();
      var data =
          await database.rawQuery("select * from $db_table order by id DESC");
      return data;
    } catch (e, stacktrace) {
      print('$e --> $stacktrace');
    }
    return [];
  }
}
