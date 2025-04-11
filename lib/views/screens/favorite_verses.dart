import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/models/favorite_verse_model.dart';
import 'package:quran_app/view%20models/favorite_verses_view_model.dart';

import '../../controllers/fontSizeController.dart';
import '../../view models/bookmark_view_model.dart';
import '../../view models/sujood_verse_view_model.dart';
import '../../view models/verse_view_model.dart';
import '../home widgets/home_appbar_menu.dart';

class FavoriteVerses extends StatelessWidget {
  final RxBool isDarkMode;

  const FavoriteVerses({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    var appBarHeight = AppBar().preferredSize.height;
    var size = Get.size;
    RxList bookmarks = [].obs;

    SujoodVerseViewModel sujoodVerseViewModel = Get.put(SujoodVerseViewModel());
    FontSizeController fontSizeController = Get.put(FontSizeController());
    Rx<FavoriteVersesViewModel> favoriteVerseViewModel =
        Get.put(FavoriteVersesViewModel()).obs;

    Rx<FavoriteVerseModel> favorites =
        favoriteVerseViewModel.value.favoriteVerseModel;

    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff1d3f5e),
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              "favorites (${favorites.value.verse_id.length})",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "SF-Pro",
                  fontWeight: FontWeight.w900,
                  fontSize: size.width * .045),
            ),
          ),
          body: Stack(
            children: [
              RawScrollbar(
                trackVisibility: true,
                padding: EdgeInsets.only(top: appBarHeight),
                thickness: 5,
                thumbColor: const Color(0xff1d3f5e),
                radius: const Radius.circular(3.0),
                interactive: true,
                thumbVisibility: true,
                child: ListView.builder(
                    itemCount: favorites.value.verse_id.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                            21, index == 0 ? 27 : 13.5, 21, 13.5),
                        child: Obx(() => Column(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.transparent),
                                    child: Row(
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Text(
                                                "${index + 1}",
                                                style: TextStyle(
                                                    fontFamily: "SF-Pro",
                                                    fontSize: size.width * .025,
                                                    fontWeight: FontWeight.w900,
                                                    color: isDarkMode.value
                                                        ? Colors.white
                                                        : const Color(
                                                            0xff1d3f5e)),
                                              ),
                                              Image.asset(
                                                "assets/images/indexDesign.png",
                                                width: size.width * .1,
                                                height: size.width * .1,
                                                color: isDarkMode.value
                                                    ? Colors.white
                                                    : const Color(0xff1d3f5e),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 21,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                favorites.value.arabic[index]
                                                    ['arabic'],
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontSize: fontSizeController
                                                        .arabicFontSize.value,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0,
                                                    fontFamily: "qalammajeed3"),
                                              ),
                                              favorites.value.isSujoodVerse[
                                                          index] ==
                                                      1
                                                  ? SizedBox(
                                                      height: size.width * .025,
                                                    )
                                                  : const SizedBox(),
                                              favorites.value.isSujoodVerse[
                                                          index] ==
                                                      1
                                                  ? const Text(
                                                      "verse of prostration (sujood)",
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                        fontFamily: "SF-Pro",
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                              SizedBox(
                                                height: size.width * .025,
                                              ),
                                              Obx(() => Text(
                                                    "${favorites.value.english[index]['english']} [${favorites.value.surah_id[index]["surah_id"]}:${favorites.value.verse_id[index]["verse_id"]}]",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontFamily: "SF-Pro",
                                                        color: isDarkMode.value
                                                            ? Colors.white
                                                                .withOpacity(
                                                                    .35)
                                                            : const Color(
                                                                    0xff1d3f5e)
                                                                .withOpacity(
                                                                    .55),
                                                        fontSize:
                                                            fontSizeController
                                                                .englishFontSize
                                                                .value,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  )),
                                              // SizedBox(height: size.width * .055,),
                                              sujoodVerseViewModel.sujoodVerseModel.value.surahID.contains(favorites.value.surah_id[index]["surah_id"])
                                                  && sujoodVerseViewModel.sujoodVerseModel.value.verseID.contains(favorites.value.verse_id[index]["verse_id"]) ? const Text(
                                                "verse of prostration (sujood)",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontFamily: "SF-Pro",
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ) : const SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
