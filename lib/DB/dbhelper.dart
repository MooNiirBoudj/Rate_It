import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'db_user_table.dart';

class DBHelper {
  static const _database_name = "Authentification.db";
  static const _database_version = 1;
  static Database? _database;

  static List<String> sql_codes = [
    DBUserTable.sql_code,
  ];

  static Future<Database> getDatabase() async {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    if (_database != null) {
      return _database!;
    }

    _database = await openDatabase(
      join(await getDatabasesPath(), _database_name),
      onCreate: (db, version) {
        for (var sql in sql_codes) {
          print('Executing SQL: $sql');
          db.execute(sql);
        }
      },
      version: _database_version,
    );
    return _database!;
  }

  Future<void> deleteOldDatabase() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, DBHelper._database_name);
  await deleteDatabase(path);
  print('Old database deleted: $path');
}

  
}
