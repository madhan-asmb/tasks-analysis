import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
// import 'package:task_analysis/models/notes_model.dart';
import 'package:task_analysis/models/user_model.dart';

class TasksAnalysisDatabase {
  static Database? _database;
  static final int _version = 1;
  static final String _dbName = 'tasks_analysis.db';
  static final String _user = 'user';
  static final String _tasks = 'tasks';
  static final String _creditCards = 'credit_cards';

  static final TasksAnalysisDatabase instance = TasksAnalysisDatabase._init();
  TasksAnalysisDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(_dbName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: _version, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    await db.execute('''
     CREATE TABLE $tableUsers(
       ${UserFields.id} $idType,
       ${UserFields.name} $textType,
       ${UserFields.gender} $textType
     )
     ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  // Crud Operations

  // User
  Future<User> createUser(User user) async {
    final db = await instance.database;
    final id = await db.insert(tableUsers, user.toJson());
    return user.copy(id: id);
  }

  Future<User> authenticateUser(String name) async {
    final db = await instance.database;

    final maps = await db.query(
      tableUsers,
      columns: UserFields.values,
      where: '${UserFields.name} = ?',
      whereArgs: [name],
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('name $name not found');
    }
  }

  Future<List<User>> readAllUsers() async {
    final db = await instance.database;
    final result = await db.query(tableUsers);
    return result.map((json) => User.fromJson(json)).toList();
  }
}
