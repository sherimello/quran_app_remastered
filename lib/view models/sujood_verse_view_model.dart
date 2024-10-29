import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:quran_app/models/sujood_verse_model.dart';
import 'package:sqflite/sqflite.dart';

import '../controllers/database_controller.dart';

class SujoodVerseViewModel extends GetxController {
  Rx<SujoodVerseModel> sujoodVerseModel = SujoodVerseModel(surahID: [].obs, verseID: [].obs).obs;


  fetchData(var dbName) async {
    final Database db = await DatabaseController().database;

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