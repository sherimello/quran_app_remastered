import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:quran_app/models/verse_model.dart';
import 'package:sqflite/sqflite.dart';

class VerseViewModel extends GetxController {
  VerseModel verseModel =
      VerseModel(arabicVerseInfo: [].obs, englishVerseInfo: [].obs);

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase("en_ar_quran.db");
    return _database!;
  }

  //this code initializes the database...
  Future<Database> initDatabase(String dbName) async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    // Check if the database file exists in the documents directory
    if (!await databaseExists(path)) {
      // Copy the database from assets to the documents directory
      await _copyDatabase(path, dbName);
    }

    // Open the database with read and write access
    return await openDatabase(
      path,
      version: 5,
      readOnly: false,
    );
  }

  Future<void> _copyDatabase(String path, dbName) async {
    // Get the asset database file
    ByteData data = await rootBundle.load('assets/documents/$dbName');
    List<int> bytes = data.buffer.asUint8List();

    // Write the bytes to the database file
    await File(path).writeAsBytes(bytes, flush: true);
  }

  fetchData(var dbName) async {
    final Database db = await database;

    // Get all table names from the database
    // var tableNames = await db.rawQuery("SELECT name FROM sqlite_master WHERE type ='table' AND name NOT LIKE 'sqlite_%'");
    var tableData = await db.rawQuery("SELECT * FROM verses");

    var arabicVerses = tableData..where((v) => v["lang_id"] == 1);
    var englishVerses = tableData..where((v) => v["lang_id"] == 2);

    verseModel = VerseModel(
        arabicVerseInfo: arabicVerses.obs, englishVerseInfo: englishVerses.obs);
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await fetchData("verses");
  }
}
