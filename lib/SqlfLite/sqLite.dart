import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlLite {
  Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "localdb.db");
    Database mydb = await openDatabase(path, onCreate: _onCreate, version: 1);
    return mydb;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE todolist (
      id TEXT NOT NULL PRIMARY KEY ,
      name TEXT,
      description TEXT ,
      done INTEGER ,
      status INTEGER ,
      duedate INTEGER 
    )

''');
    print("database created");
  }

  selectData(String sql) async {
    Database? mydatabase = await db;
    List<Map> response = await mydatabase!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydatabase = await db;
    int response = await mydatabase!.rawInsert(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydatabase = await db;
    int response = await mydatabase!.rawDelete(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydatabase = await db;
    int response = await mydatabase!.rawUpdate(sql);
    return response;
  }
}
