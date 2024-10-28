import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/data/surah_types.dart';
import 'package:quran_app/view%20models/sujood_verse_view_model.dart';
import 'package:quran_app/views/general%20widgets/bottomsheet_UIs.dart';
import 'package:quran_app/views/home%20widgets/surah_type_text.dart';

import '../../view models/surah_name_view_model.dart';

class SurahList extends StatelessWidget {
  final BottomsheetUIs bottomsheetUIs;

  const SurahList({super.key, required this.bottomsheetUIs});

  @override
  Widget build(BuildContext context) {
    SujoodVerseViewModel sujoodVerseViewModel = Get.put(SujoodVerseViewModel());
    SurahNameViewModel surahNameViewModel = Get.put(SurahNameViewModel());
    SurahTypes surahTypes = SurahTypes();
    var appBarHeight = AppBar().preferredSize.height;
    var size = Get.size;

    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount:
          surahNameViewModel.surahNameModel.value.surahEnglishName.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.only(
                    top: index == 0 ? appBarHeight + 15 : 6.5, bottom: 6.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          "${index + 1}",
                          style: TextStyle(
                              fontSize: size.width * .035,
                              fontFamily: "SF-Pro",
                              fontWeight: FontWeight.w900),
                        ),
                        Obx(() => Image.asset(
                          "assets/images/indexDesign.png",
                          width: size.width * .125,
                          height: size.width * .125,
                          color: bottomsheetUIs.isDarkMode.value
                              ? Colors.white
                              : const Color(0xff1d3f5e),
                        ))
                      ],
                    ),
                    const SizedBox(
                      width: 21,
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            surahNameViewModel.surahNameModel.value
                                .surahEnglishName[index]["translation"],
                            style: TextStyle(
                                fontSize: size.width * .045,
                                fontFamily: "SF-Pro",
                                fontWeight: FontWeight.w900),
                            softWrap: true,
                            // Enables wrapping to new line
                            overflow: TextOverflow
                                .visible, // Ensures text won’t be clipped
                          ),
                          Text(
                            surahNameViewModel.surahNameModel.value
                                .surahArabicName[index]["translation"],
                            style: TextStyle(
                                fontFamily: 'Al Majeed Quranic Font_shiped',
                                fontSize: size.width * .045,
                                fontWeight: FontWeight.w900),
                          ),
                          surahTypes.madani_surah.contains(index + 1)
                              ? const SurahTypeText(surahType: "Madani Surah")
                              : surahTypes.disputed_types.contains(index + 1)
                              ? const SurahTypeText(surahType: "(?) Disputed Location")
                              : const SurahTypeText(surahType: "Makki Surah"),
                          sujoodVerseViewModel.sujoodVerseModel.value.surahID
                              .contains(index + 1)
                              ? const Text(
                            "contains verse(s) of sujood",
                            style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontFamily: "SF-Pro",
                                fontWeight: FontWeight.w900),
                          )
                              : const SizedBox()
                        ],
                      ),
                    ),
                  ],
                ));
          }),
    ));
  }
}
