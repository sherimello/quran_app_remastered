import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/controllers/database_controller.dart';
import 'package:quran_app/view%20models/surah_name_view_model.dart';
import 'package:quran_app/view%20models/verse_view_model.dart';
import 'package:quran_app/views/general%20widgets/bottomsheet_UIs.dart';
import 'package:quran_app/views/home%20widgets/home_appbar_menu.dart';
import 'package:quran_app/views/home%20widgets/rounded_menu_buttons.dart';
import 'package:quran_app/views/home%20widgets/surah_list.dart';

import '../../controllers/animated_menu_icon_animation_controller.dart';
import '../../controllers/settings_controller.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    AnimatedMenuIconAnimationController animatedMenuIconAnimationController =
        Get.put(AnimatedMenuIconAnimationController());
    BottomsheetUIs bottomsheetUIs = Get.put(BottomsheetUIs());

    SettingsController settingsController = Get.put(SettingsController());
    // VerseViewModel verseViewModel = Get.put(VerseViewModel());
    // SurahNameViewModel surahNameViewModel = Get.put(SurahNameViewModel());

    // surahNameViewModel.fetchData("");

    var size = Get.size;
    var appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
          body: SafeArea(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  SurahList(bottomsheetUIs: bottomsheetUIs),
                  HomeAppbarMenu(
                    bottomsheetUIs: bottomsheetUIs,
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
