import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:quran_app/models/surah_name_model.dart';
import 'package:sqflite/sqflite.dart';

class SurahNameViewModel extends GetxController {
  Rx<SurahNameModel> surahNameModel = SurahNameModel(surahEnglishName: [].obs, surahArabicName: [].obs).obs;

  static Database? _database;


  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase("en_ar_quran.db");
    return _database!;
  }

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

    var arabicNames = await db.rawQuery("SELECT translation FROM surahnames WHERE lang_id = 1");
    var englishNames = await db.rawQuery("SELECT translation FROM surahnames WHERE lang_id = 2");

    surahNameModel.value = SurahNameModel(surahEnglishName: englishNames.obs, surahArabicName: arabicNames.obs);

    }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await fetchData("verses");
  }

}