import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view models/bookmark_view_model.dart';
import '../../view models/sujood_verse_view_model.dart';
import '../../view models/verse_view_model.dart';
import '../home widgets/home_appbar_menu.dart';

class BookmarkVerses extends StatelessWidget {
  final String bookmarkFolderName;
  final RxBool isDarkMode;

  const BookmarkVerses({super.key, required this.bookmarkFolderName, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    var appBarHeight = AppBar().preferredSize.height;
    var size = Get.size;
    RxList bookmarks = [].obs;
    BookmarkViewModel bookmarkViewModel = Get.put(BookmarkViewModel());

    SujoodVerseViewModel sujoodVerseViewModel = Get.put(SujoodVerseViewModel());

    init() async{
      bookmarks.value = await bookmarkViewModel.fetchBookmarkVersesFromSpecificFolder(bookmarkFolderName);
    }

    init();

    return Obx(() => Scaffold(
          body: SafeArea(
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
                        itemCount: bookmarks.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(
                                21,
                                index == 0 ? appBarHeight + 13.5 : 13.5,
                                21,
                                13.5),
                            child: Obx(() => Column(
                              children: [
                                GestureDetector(
                                  onTap: () {

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
                                                bookmarks[index]["arabic"],
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontSize: size.width * 0.061,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily:
                                                    "Al Majeed Quranic Font_shiped"),
                                              ),
                                              bookmarks[index]["isSujoodVerse"] != null
                                                  && bookmarks[index]["isSujoodVerse"] == 1? SizedBox(
                                                height: size.width * .025,
                                              ) : const SizedBox(),
                                              bookmarks[index]["isSujoodVerse"] != null
                                                  && bookmarks[index]["isSujoodVerse"] == 1? const Text(
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
                                                bookmarks[index]["english"],
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
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
                ],
              )),
        ));
  }
}