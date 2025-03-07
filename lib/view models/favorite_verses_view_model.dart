import 'package:get/get.dart';
import 'package:quran_app/models/bookmark_model.dart';
import 'package:quran_app/models/favorite_verse_model.dart';
import 'package:sqflite/sqflite.dart';

import '../controllers/database_controller.dart';

class FavoriteVersesViewModel extends GetxController {
  late Rx<FavoriteVerseModel> favoriteVerseModel = FavoriteVerseModel(
          arabic: [].obs,
          english: [].obs,
          surah_id: [].obs,
          verse_id: [].obs,
          isSujoodVerse: [].obs)
      .obs;

  fetchFavoriteVerses() async {
    final Database db = await DatabaseController().database;

    var favorites = await db.rawQuery("SELECT * FROM favorites");

    var arabic = await db.rawQuery("SELECT arabic FROM favorites");
    var english = await db.rawQuery("SELECT english FROM favorites");
    var surah_id = await db.rawQuery("SELECT surah_id FROM favorites");
    var verse_id = await db.rawQuery("SELECT verse_id FROM favorites");
    var isSujoodVerse =
        await db.rawQuery("SELECT isSujoodVerse FROM favorites");

    favoriteVerseModel.value = FavoriteVerseModel(
        isSujoodVerse: isSujoodVerse.obs,
        arabic: arabic.obs,
        english: english.obs,
        surah_id: surah_id.obs,
        verse_id: verse_id.obs);
    print(favorites);
    print(arabic);
  }

  deleteData(int surah_id, verse_id) async {
    final Database db = await DatabaseController().database;

    await db.rawDelete(
        "DELETE FROM favorites WHERE surah_id = ? AND verse_id = ?",
        [surah_id, verse_id]);

    // fetchBookmarkFolderNames();
  }

  addVerseAsFavorite(
      {required String arabicVerse,
      required String englishVerse,
      required int surah_id,
      required int verse_id,
      required int isSujoodVerse}) async {
    final Database db = await DatabaseController().database;

    // await db.rawQuery("ALTER TABLE bookmarks ADD COLUMN isSujoodVerse BOOLEAN");
    await db.rawQuery(
        "INSERT INTO favorites (arabic, english, surah_id, verse_id, isSujoodVerse) VALUES (?, ?, ?, ?, ?)",
        [
          arabicVerse,
          englishVerse,
          surah_id,
          verse_id,
          isSujoodVerse
        ]);

    fetchFavoriteVerses();

    var favorites = await db
        .rawQuery("SELECT * FROM favorites");

    print(favorites);
  }


  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await fetchFavoriteVerses();
  }
}
