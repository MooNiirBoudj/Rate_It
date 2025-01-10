import '/DB/db_base.dart';

class DBUserTable extends DBBaseTable {
  @override
  var db_table = 'user';

  static String sql_code = '''
    CREATE TABLE user (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      Name TEXT,
      userName TEXT UNIQUE,
      password TEXT
    )
  ''';
}
