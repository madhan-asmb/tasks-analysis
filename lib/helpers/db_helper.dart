import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_analysis/models/credit_cards.dart';
// import 'package:task_analysis/models/notes_model.dart';
import 'package:task_analysis/models/user_model.dart';

class TasksAnalysisDatabase {
  static Database? _database;
  static final int _version = 1;
  static final String _dbName = 'tasks_analysis.db';

  // Data types;
  static final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static final textType = 'TEXT NOT NULL';
  static final boolType = 'BOOLEAN NOT NULL';
  static final integerType = 'INTEGER NOT NULL';

  static final TasksAnalysisDatabase instance = TasksAnalysisDatabase._init();
  TasksAnalysisDatabase._init();

  Future<Database> get database async {
    print('_database: $_database');
    if (_database != null) return _database!;
    _database = await _initDB(_dbName);
    return _database!;
  }

  Future onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<Database> _initDB(String filePath) async {
    // final dbPath = await getDatabasesPath();
    print('_dbName: $filePath');
    final dbPath = await getApplicationDocumentsDirectory();
    final path = join(dbPath.path, filePath);
    return await openDatabase(
      path,
      version: _version,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
      onConfigure: onConfigure,
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  // initialy this method will be called
  Future _createDB(Database db, int version) async {
    //New users
    print("create==> version: $version");
    var batch = db.batch();
    // We create all the tables
    _crateUsersTable(batch);
    _crateCreditCardTable(batch);
    // _addColumnsInCreditCardTable(batch);
    await batch.commit();
  }

  // when the vesion is changed this method is called here we can update schema
  // creating new tables or adding columns to the existing tables
  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    //exsiting users and updating the schema
    print("update==> oldVersion: $oldVersion, newVersion: $newVersion");
    var batch = db.batch();
   
    if (newVersion == 2) {
      
    }
    await batch.commit();
  }

  // Tables
  void _crateUsersTable(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS $tableUsers');
    batch.execute('''CREATE TABLE $tableUsers(
       ${UserFields.id} $idType,
       ${UserFields.name} $textType,
       ${UserFields.gender} $textType,
       ${UserFields.userpassword} $textType
     )''');
  }

  void _crateCreditCardTable(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS $tableCreditCard');
    batch.execute('''CREATE TABLE $tableCreditCard(
       ${CreditCardFields.id} $idType,
       ${CreditCardFields.userId} $integerType,
       ${CreditCardFields.bankName} $textType,
       ${CreditCardFields.cardNumber} $textType,
       ${CreditCardFields.nameOnCard} $textType,
       ${CreditCardFields.expriryDate} $textType,
       ${CreditCardFields.cardCvv} $textType,
       ${CreditCardFields.cardColor} $textType DEFAULT 'blue',
       ${CreditCardFields.createdAt} $textType DEFAULT CURRENT_TIMESTAMP,
       ${CreditCardFields.updatedAt} $textType DEFAULT CURRENT_TIMESTAMP
     )
     ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  // User Operations =====================================
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
    print(maps);

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('name $name not found');
    }
  }

  Future<List<User>> readAllUsers() async {
    final db = await instance.database;
    print(db);
    final result = await db.query(tableUsers);
    return result.map((json) => User.fromJson(json)).toList();
  }

  // Credit cards ================================================
  Future<CreditCard> createCreditCard(CreditCard creditCard) async {
    final db = await instance.database;
    final id = await db.insert(tableCreditCard, creditCard.toJson());
    return creditCard.copy(id: id);
  }

  Future<List<CreditCard>> readAllCreditCards() async {
    final db = await instance.database;
    final orderBy = '${CreditCardFields.updatedAt} DESC';
    final result = await db.query(tableCreditCard, orderBy: orderBy);
    return result.map((json) => CreditCard.fromJson(json)).toList();
  }
}
