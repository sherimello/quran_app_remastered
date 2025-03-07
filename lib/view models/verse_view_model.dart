import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:quran_app/models/verse_model.dart';
import 'package:sqflite/sqflite.dart';

import '../controllers/database_controller.dart';

class VerseViewModel extends GetxController {

  final int surahNumber;

  VerseViewModel({required this.surahNumber});

  Rx<VerseModel> verseModel =
      VerseModel(arabicVerseInfo: [].obs, englishVerseInfo: [].obs).obs;

  fetchData({required surahNumber}) async {
    final Database db = await DatabaseController().database;

    // Get all table names from the database
    // var tableNames = await db.rawQuery("SELECT name FROM sqlite_master WHERE type ='table' AND name NOT LIKE 'sqlite_%'");
    var tableData = await db.rawQuery("SELECT * FROM verses WHERE surah_id = $surahNumber");

    var arabicVerses = await db.rawQuery("SELECT * FROM verses WHERE surah_id = $surahNumber AND lang_id = 1");
    var englishVerses = await db.rawQuery("SELECT * FROM verses WHERE surah_id = $surahNumber AND lang_id = 2");

    verseModel.value = VerseModel(
        arabicVerseInfo: arabicVerses.obs, englishVerseInfo: englishVerses.obs);
    print(verseModel.value.englishVerseInfo[0]["text"]);
  }

  Future<void> fetchVersesByKeyword({required String keyword}) async {
    final Database db = await DatabaseController().database;

    // Use LIKE query to search for the keyword in all verses
    var arabicVerses = await db.rawQuery(
        "SELECT * FROM verses WHERE text LIKE '%$keyword%' AND lang_id = 1");

    var englishVerses = await db.rawQuery(
        "SELECT * FROM verses WHERE text LIKE '%$keyword%' AND lang_id = 2");

    // Update the VerseModel with the fetched data
    verseModel.value = VerseModel(
      arabicVerseInfo: arabicVerses.obs,
      englishVerseInfo: englishVerses.obs,
    );

    // Print the verses for debugging
    print("Arabic Verses:");
    for (var verse in arabicVerses) {
      print(verse["text"]);
    }

    print("English Verses:");
    for (var verse in englishVerses) {
      print(verse["text"]);
    }
  }


  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await fetchData(surahNumber: surahNumber);
  }
}
