
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'pets.db'),
      onCreate: (db, version) {
        _createDb(db);
      },
      version: 1
    );
  }

  static void _createDb(sql.Database db) {
    db.execute("""
      CREATE TABLE pets (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR(50),
      imageUrl TEXT, descricao TEXT, idade INTEGER, sexo VARCHAR(8), 
      cor VARCHAR(20), bio TEXT)
    """);
    db.execute("""CREATE TABLE remedios (id INTEGER PRIMARY KEY AUTOINCREMENT, 
    nome VARCHAR(50), data DATETIME, pet INTEGER,
    FOREIGN KEY (pet) REFERENCES pets (id) ON DELETE NO ACTION 
    ON UPDATE NO ACTION)""");
  }

  static Future<void> insertData(String table, Map<String, Object> dados) async {
    final db = await database();
    await db.insert(table, dados,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await database();
    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> getDataWhere(String table, List<String> colunas,
      String whereString, List<dynamic> whereArgumento) async {
    final db = await database();
    return db.query(table, columns: colunas, where: whereString,
        whereArgs: whereArgumento);
  }

  static Future<void> editData(String table, Map<String, Object> dados,
      String whereString, List<dynamic> whereArgumento) async {
    final db = await database();
    await db.update(table, dados, where: whereString, whereArgs: whereArgumento);
  }
}