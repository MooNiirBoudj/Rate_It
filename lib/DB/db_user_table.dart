import 'db_base.dart';

class DBUserTable extends DBBaseTable {
  @override
  var db_table = 'users';

  static String sql_code = '''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      firstName TEXT,
      lastName TEXT,
      email TEXT UNIQUE,
      password TEXT,
      gender TEXT
    )
  ''';
}
