import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:quran_app/models/sujood_verse_model.dart';
import 'package:sqflite/sqflite.dart';

class SujoodVerseViewModel extends GetxController {
  Rx<SujoodVerseModel> sujoodVerseModel = SujoodVerseModel(surahID: [].obs, verseID: [].obs).obs;

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

    var sujoodSurahs = [];
    var sujoodVerses = [];

    var sujoodVerseInfo = await db.rawQuery("SELECT * FROM sujood_verses");
      for (var v in sujoodVerseInfo) {
        sujoodSurahs.add(v["surah_id"]);
        sujoodVerses.add(v["verse_id"]);
      print(v);
    }

    sujoodVerseModel.value = SujoodVerseModel(surahID: sujoodSurahs.obs, verseID: sujoodVerses.obs);

    print(sujoodVerseModel);

  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await fetchData("verses");
  }

}