import 'package:get/get.dart';
import 'package:quran_app/models/search_verse_model.dart';
import 'package:sqflite/sqflite.dart';

import '../controllers/database_controller.dart';
import '../models/verse_model.dart';

class VerseSearchViewModel extends GetxController {

  Rx<SearchVerseModel> searchVerseModel =
      SearchVerseModel(arabicVerseInfo: [].obs, englishVerseInfo: [].obs).obs;

  // Future<void> fetchVersesByKeyword({required String keyword}) async {
  //   final Database db = await DatabaseController().database;
  //
  //   // // Use LIKE query to search for the keyword in all verses
  //   // var arabicVerses = await db.rawQuery(
  //   //     "SELECT * FROM verses WHERE text LIKE '%$keyword%' AND lang_id = 1");
  //
  //   var englishVerses = await db.rawQuery(
  //       "SELECT * FROM verses WHERE text LIKE '%$keyword%' AND lang_id = 2");
  //
  //   List<Map<String, dynamic>> verseInfo = englishVerses.map((verse) {
  //     return {
  //       'verse_id': verse['verse_id'],
  //       'surah_id': verse['surah_id'],
  //     };
  //   }).toList();
  //
  //   List<String> conditions = verseInfo
  //       .map((v) => "(verse_id = ${v['verse_id']} AND surah_id = ${v['surah_id']})")
  //       .toList();
  //
  //   String arabicCondition = conditions.join(' OR ');
  //
  //   var arabicVerses = await db.rawQuery(
  //   "SELECT * FROM verses WHERE ($arabicCondition) AND lang_id = 1");
  //   // var surahID = await db.rawQuery(
  //   //     "SELECT * FROM surah_id WHERE text LIKE '%$keyword%'");
  //   //
  //   // var verseID = await db.rawQuery(
  //   //     "SELECT * FROM verse_id WHERE text LIKE '%$keyword%'");
  //
  //   // Update the VerseModel with the fetched data
  //   searchVerseModel.value = SearchVerseModel(
  //     arabicVerseInfo: arabicVerses.obs,
  //     englishVerseInfo: englishVerses.obs,
  //     // surahID: surahID.obs,
  //     // verseID: verseID.obs
  //   );
  //
  //   // Print the verses for debugging
  //   print("Arabic Verses:");
  //   for (var verse in arabicVerses) {
  //     print(verse);
  //   }
  //
  //   print("English Verses:");
  //   for (var verse in englishVerses) {
  //     print(verse);
  //   }
  // }

  Future<void> fetchVersesByKeyword({required String keyword}) async {
    final Database db = await DatabaseController().database;

    // Step 1: Fetch English verses that contain the keyword
    var englishVerses = await db.rawQuery(
        "SELECT verse_id, surah_id, text FROM verses WHERE text LIKE '%$keyword%' AND lang_id = 2");

    if (englishVerses.isEmpty) {
      print("No verses found for the keyword: $keyword");
      return;
    }

    // Step 2: Extract unique verse_id and surah_id pairs
    List<Map<String, dynamic>> verseInfo = englishVerses.map((verse) {
      return {
        'verse_id': verse['verse_id'],
        'surah_id': verse['surah_id'],
      };
    }).toList();

    // Step 3: Query for Arabic verses in manageable batches
    const int batchSize = 900; // SQLite's safe limit
    List<Map<String, dynamic>> arabicVerses = [];

    for (int i = 0; i < verseInfo.length; i += batchSize) {
      // Take a batch of verse_id and surah_id pairs
      var batch = verseInfo.skip(i).take(batchSize).toList();

      // Build an efficient IN query using surah_id and verse_id pairs
      List<String> conditions = batch
          .map((v) => "(verse_id = ${v['verse_id']} AND surah_id = ${v['surah_id']})")
          .toList();

      String conditionString = conditions.join(" OR ");

      // Fetch Arabic verses for the current batch
      var batchResults = await db.rawQuery(
          "SELECT * FROM verses WHERE lang_id = 1 AND ($conditionString)");

      arabicVerses.addAll(batchResults);
    }

    // Step 4: Update the VerseModel with results
    searchVerseModel.value = SearchVerseModel(
      arabicVerseInfo: arabicVerses.obs,
      englishVerseInfo: englishVerses.obs,
    );

    // Debugging output
    print("Matched English Verses:");
    for (var verse in englishVerses) {
      print("Surah: ${verse['surah_id']}, Verse: ${verse['verse_id']}, Text: ${verse['text']}");
    }

    print("Corresponding Arabic Verses:");
    for (var verse in arabicVerses) {
      print("Surah: ${verse['surah_id']}, Verse: ${verse['verse_id']}, Text: ${verse['text']}");
    }
  }


}