import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/controllers/fontSizeController.dart';
import 'package:quran_app/view%20models/bookmark_view_model.dart';
import 'package:quran_app/view%20models/verse_view_model.dart';
import 'package:quran_app/views/general%20widgets/bottomsheet_UIs.dart';
import 'package:quran_app/views/home%20widgets/home_appbar_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurahScreen extends StatelessWidget {
  final RxBool isDarkMode;
  final int surahNumber;
  final BottomsheetUIs bottomsheetUIs;
  final String surahName;
  final List<dynamic> sujoodVerses;

  const SurahScreen({
    super.key,
    required this.isDarkMode,
    required this.surahNumber,
    required this.bottomsheetUIs,
    required this.surahName, required this.sujoodVerses,
  });

  @override
  Widget build(BuildContext context) {

    VerseViewModel verseViewModel =
    Get.put(VerseViewModel(surahNumber: surahNumber));
    BookmarkViewModel bookmarkViewModel = Get.put(BookmarkViewModel());
    var size = Get.size;
    var appBarHeight = AppBar().preferredSize.height;

    FontSizeController fontSizeController = Get.put(FontSizeController());

    return Obx(() => Scaffold(
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: Stack(
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
                      itemCount: verseViewModel
                          .verseModel.value.arabicVerseInfo.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                              21,
                              index == 0 ? appBarHeight + 13.5 : 13.5,
                              21,
                              13.5),
                          child: Obx(() => Column(
                            children: [
                              (surahNumber == 1 ||
                                  surahNumber == 9) ? const SizedBox() : index == 0 ? Center(
                                    child: Text(
                                      'd',
                                      textAlign: TextAlign.center,
                                      // textScaleFactor: ,
                                      style: TextStyle(
                                        height: 0,
                                        inherit: true,
                                        // color: const Color(0xff1d3f5e),
                                        color: isDarkMode.value ? Colors.white : Colors.black,
                                        // fontFamily: 'Bismillah Script',
                                        fontFamily: '110_Besmellah Normal',
                                        fontStyle: FontStyle.normal,
                                        fontSize: AppBar().preferredSize.height * .61,
                                      ),
                                    ),
                                  ) : const SizedBox(),
                              GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(bottomsheetUIs.verseOptions(
                                        bookmarkViewModel.bookmarkModel.value.folderName, bookmarkViewModel.obs, verseViewModel.verseModel.value
                                        .arabicVerseInfo[index]["text"], verseViewModel.verseModel.value
                                        .englishVerseInfo[index]["text"],
                                    surahNumber, index + 1, sujoodVerses.contains(index + 1) ? 1 : 0));
                                    // Get.bottomSheet(bottomsheetUIs.addBookMarkWidget(bookmarkViewModel.bookmarkModel.value.folderName, bookmarkViewModel.obs,
                                    //     verseViewModel.verseModel.value
                                    //         .arabicVerseInfo[index]["text"], verseViewModel.verseModel.value
                                    //         .englishVerseInfo[index]["text"], surahNumber, index + 1, sujoodVerses.contains(index + 1) ? 1 : 0),);
                                  },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent
                                  ),
                                  child: Row(
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional.centerStart,
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
                                                      : const Color(0xff1d3f5e)),
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
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              verseViewModel.verseModel.value
                                                  .arabicVerseInfo[index]["text"],
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: fontSizeController.arabicFontSize.value,
                                                  // fontSize: size.width * 0.061,
                                                  // fontWeight: FontWeight.w400,
                                                  letterSpacing: 0,
                                                  // fontFamily: "bismillah"
                                                  // fontFamily: "hafs"
                                                  fontFamily: "qalammajeed3"
                                                  // fontFamily: "Al Majeed Quranic Font_shiped"
                                                  // fontFamily:
                                                  // "KFGQPC HafsEx1 Uthmanic Script"
                                              ),
                                                  // "Al Majeed Quranic Font_shiped"),
                                            ),
                                            sujoodVerses.contains(index + 1) ? SizedBox(
                                              height: size.width * .025,
                                            ) : const SizedBox(),
                                            sujoodVerses.contains(index + 1) ? const Text(
                                              "verse of prostration (sujood)",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontFamily: "SF-Pro",
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w900,
                                              ),
                                            ) : const SizedBox(),
                                            SizedBox(
                                              height: size.width * .025,
                                            ),
                                            Obx(() => Text(
                                              verseViewModel.verseModel.value
                                                  .englishVerseInfo[index]["text"],
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: fontSizeController.englishFontSize.value,
                                                  fontFamily: "SF-Pro",
                                                  color: isDarkMode.value
                                                      ? Colors.white
                                                      .withOpacity(.35)
                                                      : const Color(0xff1d3f5e)
                                                      .withOpacity(.55),
                                                  fontWeight: FontWeight.w900,
                                                  fontStyle: FontStyle.italic),
                                            ))
                                            // SizedBox(height: size.width * .055,),
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
                Container(
                  width: size.width,
                  height: MediaQuery.of(context).padding.top,
                  color: const Color(0xff1d3f5e),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: HomeAppbarMenu(
                    bottomsheetUIs: bottomsheetUIs,
                    surahName: surahName,
                    verseNumber: verseViewModel
                        .verseModel.value.arabicVerseInfo.length
                        .toString(),
                    shouldShowSurahInfo: true,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
