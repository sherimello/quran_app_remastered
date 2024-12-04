import 'package:get/get.dart';
import 'package:quran_app/models/bookmark_model.dart';
import 'package:sqflite/sqflite.dart';

import '../controllers/database_controller.dart';

class BookmarkViewModel extends GetxController {


  Rx<BookmarkModel> bookmarkModel = BookmarkModel(folderName: [].obs).obs;


  fetchBookmarkFolderNames() async {
    final Database db = await DatabaseController().database;

    var folderNames = await db.rawQuery("SELECT * FROM bookmark_folders");

    bookmarkModel.value = BookmarkModel(folderName: folderNames.obs);
    print(bookmarkModel.value.folderName);
  }

  insertData(String folderName) async {
    final Database db = await DatabaseController().database;

    await db.rawQuery("INSERT INTO bookmark_folders (folder_name) VALUES (?)", [folderName]);

    fetchBookmarkFolderNames();
  }

  deleteData(String folderName) async {
    final Database db = await DatabaseController().database;

    await db.rawDelete("DELETE FROM bookmark_folders WHERE folder_name = ?", [folderName]);

    fetchBookmarkFolderNames();
  }

  addVerseAsBookmark(String folderName, arabicVerse, englishVerse, surah_id, verse_id, int isSujoodVerse) async {

    final Database db = await DatabaseController().database;

    // await db.rawQuery("ALTER TABLE bookmarks ADD COLUMN isSujoodVerse BOOLEAN");
    await db.rawQuery("INSERT INTO bookmarks (folder_name, arabic, english, surah_id, verse_id, isSujoodVerse) VALUES (?, ?, ?, ?, ?, ?)", [folderName, arabicVerse, englishVerse, surah_id, verse_id, isSujoodVerse]);

    var bookmarks = await db.rawQuery("SELECT * FROM bookmarks WHERE folder_name = ?", ['test0']);

    print(bookmarks);

  }

  fetchBookmarkVersesFromSpecificFolder(String name) async {
    final Database db = await DatabaseController().database;

    var bookmarks = await db.rawQuery("SELECT * FROM bookmarks WHERE folder_name = ?", [name]);

    print(bookmarks);
    return bookmarks;
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await fetchBookmarkFolderNames();
  }
}