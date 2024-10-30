import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:quran_app/controllers/database_controller.dart';
import 'package:quran_app/models/surah_name_model.dart';
import 'package:sqflite/sqflite.dart';

class SurahNameViewModel extends GetxController {


  Rx<SurahNameModel> surahNameModel = SurahNameModel(surahEnglishName: [].obs, surahArabicName: [].obs).obs;


  fetchData(var dbName) async {
    final Database db = await DatabaseController().database;

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