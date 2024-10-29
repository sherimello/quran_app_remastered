import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:quran_app/models/verse_model.dart';
import 'package:sqflite/sqflite.dart';

import '../controllers/database_controller.dart';

class VerseViewModel extends GetxController {

  final Database database;

  VerseViewModel({required this.database});

  VerseModel verseModel =
      VerseModel(arabicVerseInfo: [].obs, englishVerseInfo: [].obs);

  fetchData(var dbName) async {
    final Database db = await DatabaseController().database;

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
