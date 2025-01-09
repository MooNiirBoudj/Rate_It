import 'dart:async';
import 'dart:io';
//import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'db_user_table.dart';
//import 'db_user_table.dart'; // Import the DBUserTable file

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
        // Loop through all SQL table creation codes
        for (var sql in sql_codes) {
          db.execute(sql);
        }
      },
      version: _database_version,
      onUpgrade: (db, oldVersion, newVersion) {
        // Handle database upgrades here if necessary
      },
    );
    return _database!;
  }
}
