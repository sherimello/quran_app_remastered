import 'package:get/get.dart';

class FavoriteVerseModel {
  final RxList<dynamic> arabic, english;
  final RxList<dynamic> surah_id, verse_id, isSujoodVerse;

  FavoriteVerseModel({
    required this.isSujoodVerse,
    required this.arabic,
    required this.english,
    required this.surah_id,
    required this.verse_id,
  });
}
