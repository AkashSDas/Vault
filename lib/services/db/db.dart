import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import './Account.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton
  static Database _database; // Singleton

  String accountTable = 'account_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPassword = 'password';

  // Creating instance of the database
  DatabaseHelper._createInstance();

  // Creating database only once (if not created)
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
    CREATE TABLE $accountTable(
      $colId INTEGER PRIMARY KEY AUTOINCREMENT, 
      $colTitle TEXT, 
      $colDescription TEXT, 
      $colPassword TEXT
    )''');
  }

  Future<Database> initalizeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'database.db';

    var accountsDb = await openDatabase(path, version: 1, onCreate: _createDb);
    return accountsDb;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initalizeDatabase();
    }
    return _database;
  }

  // Getting all Account objects from database
  Future<List<Map<String, dynamic>>> getAccountMapList() async {
    Database db = await this.database;
    // var result = await db.rawQuery('SELECT * FROM $accountTable');
    var result = await db.query(accountTable);
    return result;
  }

  /// Adding new accounts
  /// Return: int(whether operation was successful or not)
  Future<int> insertAccount(Account account) async {
    Database db = await this.database;
    var result = await db.insert(accountTable, account.toMap());
    return result;
  }

  /// Updating existing accounts
  /// Return: int(whether operation was successful or not)
  Future<int> updateAccount(Account account) async {
    Database db = await this.database;
    var result = await db.update(accountTable, account.toMap(),
        where: '$colId = ?', whereArgs: [account.id]);
    return result;
  }

  /// Deleting existing accounts
  /// Return: int(whether operation was successful or not)
  Future<int> deleteAccount(int id) async {
    Database db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $accountTable WHERE $colId = $id');
    return result;
  }

  // Getting number of accounts
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $accountTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Getting list of account objects
  Future<List<Account>> getAccountList() async {
    var accountMapList = await this.getAccountMapList();
    List<Account> accountList = List<Account>();
    for (int i = 0; i < accountMapList.length; i++) {
      accountList.add(Account.fromMapToObject(accountMapList[i]));
    }
    return accountList;
  }
}
