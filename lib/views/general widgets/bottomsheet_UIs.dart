import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/controllers/fontSizeController.dart';
import 'dart:math';
import 'package:quran_app/view%20models/bookmark_view_model.dart';
import 'package:quran_app/view%20models/favorite_verses_view_model.dart';
import 'package:quran_app/views/screens/bookmark_verses.dart';
import 'package:quran_app/views/screens/surah_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomsheetUIs extends GetxController {
  var size = Get.size;
  RxBool isDarkMode = false.obs;
  RxDouble arabicFontSize = 21.0.obs;
  RxDouble englishFontSize = 15.0.obs;

  FontSizeController fontSizeController = Get.put(FontSizeController());

  @override
  Future<void> onInit() async {
    super.onInit();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("theme")) {
      if (sharedPreferences.getString("theme")! == "light") {
        isDarkMode.value = false;
        Get.changeTheme(ThemeData.light());
        Get.changeThemeMode(ThemeMode.light);
      } else {
        isDarkMode.value = true;
        Get.changeTheme(ThemeData.dark());
        Get.changeThemeMode(ThemeMode.dark);
      }
    } else {
      Get.changeTheme(ThemeData.light());
      Get.changeThemeMode(ThemeMode.light);
    }

    if (sharedPreferences.containsKey("arabicFontSize")) {
      arabicFontSize.value = sharedPreferences.getDouble("arabicFontSize")!;
    } else {
      arabicFontSize.value = (size.width * 0.061);
    }

    if (sharedPreferences.containsKey("englishFontSize")) {
      englishFontSize.value = sharedPreferences.getDouble("englishFontSize")!;
    } else {
      englishFontSize.value = 15.0;
    }
  }

  Widget themeList() {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(11.0),
          child: Container(
            decoration: BoxDecoration(
                color:
                    isDarkMode.value ? const Color(0xff1d3f5e) : Colors.white,
                borderRadius: BorderRadius.circular(31)),
            child: Padding(
              padding: const EdgeInsets.all(21.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      isDarkMode.value = false;
                      Get.changeTheme(ThemeData.light());
                      Get.changeThemeMode(ThemeMode.light);
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.setString("theme", "light");
                      // Get.reloadAll(force: true);
                      print("Changed to Light Theme");
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.light_mode,
                          color: isDarkMode.value ? Colors.white : Colors.black,
                        ),
                        Text(
                          "  light mode",
                          style: TextStyle(
                            fontSize: size.width * .055,
                            fontFamily: "SF-Pro",
                            color:
                                isDarkMode.value ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  GestureDetector(
                    onTap: () async {
                      isDarkMode.value = true;
                      Get.changeTheme(ThemeData.dark());
                      Get.changeThemeMode(ThemeMode.dark);
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.setString("theme", "dark");
                      // Get.reloadAll(force: true);
                      // Get.reloadAll();
                      // Get.changeTheme(ThemeData.dark()); // Change to dark theme
                      print("Changed to Dark Theme");
                    },
                    child: SizedBox(
                      child: Row(
                        children: [
                          Icon(
                            Icons.dark_mode,
                            color:
                                isDarkMode.value ? Colors.white : Colors.black,
                          ),
                          Text(
                            "  dark mode",
                            style: TextStyle(
                              fontSize: size.width * .055,
                              fontFamily: "SF-Pro",
                              color: isDarkMode.value
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w900,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget aboutWidget() {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(21.0),
          child: Container(
            width: size.width,
            decoration: BoxDecoration(
                color:
                    isDarkMode.value ? const Color(0xff1d3f5e) : Colors.white,
                borderRadius: BorderRadius.circular(31)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 21),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_rounded,
                          color: isDarkMode.value
                              ? Colors.white
                              : const Color(0xff1d3f5e),
                        ),
                        Text(
                          "  about",
                          style: TextStyle(
                              fontFamily: "SF-Pro",
                              fontWeight: FontWeight.w900,
                              fontSize: size.width * .055,
                              color: isDarkMode.value
                                  ? Colors.white
                                  : const Color(0xff1d3f5e)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(21.0),
                    child: Container(
                      width: size.width * .25,
                      height: size.width * .25,
                      decoration: BoxDecoration(
                          color: isDarkMode.value
                              ? Colors.white
                              : const Color(0xff1d3f5e),
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Image.asset(
                            "assets/images/dev picture.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 11.0),
                    child: Text(
                      "السَّلَامُ عَلَيْكُمْ وَرَحْمَةُ ٱللَّهِ وَبَرَكاتُهُ",
                      style: TextStyle(
                          wordSpacing: 2,
                          fontFamily: 'Al_Mushaf',
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color:
                              isDarkMode.value ? Colors.white : Colors.black),
                      textScaler: TextScaler.linear(Get.pixelRatio),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 11.0),
                    child: Text.rich(
                      TextSpan(
                          style: TextStyle(
                              color: isDarkMode.value
                                  ? Colors.white
                                  : Colors.black),
                          children: const [
                            TextSpan(
                              text:
                                  "\nthis app is intended to be a Sadaqatul Jariyah ",
                              style: TextStyle(
                                fontFamily: 'varela-round.regular',
                              ),
                            ),
                            TextSpan(
                              text:
                                  "(long-term kindness that accrues ongoing reward from ALLAH (SWT)) ",
                              style: TextStyle(
                                  fontFamily: 'varela-round.regular',
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  "for everyone associated in the making of it.  we will make it opensource with the very first stable release (",
                              style: TextStyle(
                                fontFamily: 'varela-round.regular',
                              ),
                            ),
                            TextSpan(
                              text: "إن شاء الله",
                              style: TextStyle(
                                  wordSpacing: 2,
                                  fontFamily: 'Al Majeed Quranic Font_shiped',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                                text:
                                    "). none of the users' personal data are stored in our servers without encryption. even we won't be able to decrypt those data. keep us in your prayers.\n"),
                          ]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    "مَعَ ٱلسَّلَامَة\n",
                    style: TextStyle(
                        wordSpacing: 2,
                        fontFamily: 'Al Majeed Quranic Font_shiped',
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode.value ? Colors.white : Colors.black),
                    textScaler: TextScaler.linear(Get.pixelRatio),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget addBookMarkWidget(
      List<dynamic> folderNames,
      Rx<BookmarkViewModel> bookmarkViewModel,
      arabicVerse,
      englishVerse,
      surah_id,
      verse_id,
      int isSujoodVerse) {
    TextEditingController textEditingController = TextEditingController();
    RxBool shouldShowDeletionUI = false.obs;
    RxInt deletionIndex = 0.obs, bookMarkFolderIndex = 0.obs;
    return Padding(
      padding: const EdgeInsets.all(21.0),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          color: isDarkMode.value ? const Color(0xff1d3f5e) : Colors.white,
          borderRadius: BorderRadius.circular(31),
        ),
        child: Column(
          children: [
            Obx(() => AnimatedPadding(
                  duration: const Duration(milliseconds: 555),
                  curve: Curves.linearToEaseOut,
                  padding: EdgeInsets.all(shouldShowDeletionUI.value ? 21 : 0),
                  child: GestureDetector(
                    onTap: () {
                      shouldShowDeletionUI.value = false;
                      deletionIndex.value = 0;
                    },
                    child: AnimatedContainer(
                      width: shouldShowDeletionUI.value ? size.width : 0,
                      height: shouldShowDeletionUI.value ? size.width * .11 : 0,
                      duration: const Duration(milliseconds: 555),
                      curve: Curves.linearToEaseOut,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(17)),
                      child: Center(
                        child: Text(
                          "cancel",
                          style: TextStyle(
                              fontFamily: "SF-Pro",
                              fontWeight: FontWeight.w900,
                              fontSize: size.width * .041,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(21, 21, 21, 0),
              child: Row(
                children: [
                  Icon(
                    Icons.book,
                    color: isDarkMode.value ? Colors.white : Colors.black,
                  ),
                  Text(
                    "  bookmark folder:",
                    style: TextStyle(
                      fontFamily: "SF-Pro",
                      fontWeight: FontWeight.w900,
                      color: isDarkMode.value ? Colors.white : Colors.black,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(21, 11, 21, 11),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: isDarkMode.value
                        ? Colors.white.withOpacity(.31)
                        : const Color(0x311d3f5e)),
                child: TextField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                    filled: true,
                    // Ensures fillColor is applied
                    fillColor: Colors.transparent,
                    // Transparent background
                    border: InputBorder.none,
                    // No border
                    hintText: 'folder name',
                    hintStyle: TextStyle(
                        color: Colors.grey), // Optional: color of the hint text
                  ),
                  style: TextStyle(color: Colors.black), // Text color
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                bookmarkViewModel.value.insertData(textEditingController.text);
              },
              child: Container(
                width: size.width * .55,
                height: size.width * .11,
                decoration: BoxDecoration(
                    color: isDarkMode.value
                        ? Colors.white
                        : const Color(0xff1d3f5e),
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                  child: Text(
                    "create folder",
                    style: TextStyle(
                        fontFamily: "SF-Pro",
                        fontWeight: FontWeight.w900,
                        fontSize: size.width * .041,
                        color: isDarkMode.value ? Colors.black : Colors.white),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(21, 21, 21, 0),
              child: Row(
                children: [
                  Icon(Icons.book),
                  Text(
                    "  all bookmark folders:",
                    style: TextStyle(
                        fontFamily: "SF-Pro", fontWeight: FontWeight.w900),
                  )
                ],
              ),
            ),
            Obx(() => Expanded(
                  child: ListView.builder(
                    itemCount: bookmarkViewModel
                        .value.bookmarkModel.value.folderName.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 21, vertical: 5.5),
                        child: Obx(() => GestureDetector(
                              onLongPress: () {
                                deletionIndex.value = index;
                                shouldShowDeletionUI.value = true;
                                print("long pressed");
                              },
                              onTap: () {
                                if (shouldShowDeletionUI.value) {
                                  bookmarkViewModel.value.deleteData(
                                      bookmarkViewModel
                                              .value
                                              .bookmarkModel
                                              .value
                                              .folderName[deletionIndex.value]
                                          ["folder_name"]);
                                  shouldShowDeletionUI.value = false;
                                  deletionIndex.value = 0;
                                } else {
                                  bookMarkFolderIndex.value = index;
                                  bookmarkViewModel.value.addVerseAsBookmark(
                                      bookmarkViewModel.value.bookmarkModel
                                                  .value.folderName[
                                              bookMarkFolderIndex.value]
                                          ["folder_name"],
                                      arabicVerse,
                                      englishVerse,
                                      surah_id,
                                      verse_id,
                                      isSujoodVerse);
                                  Navigator.pop(context);
                                }
                              },
                              child: AnimatedContainer(
                                width: size.width,
                                height: size.width * .11,
                                duration: const Duration(milliseconds: 555),
                                curve: Curves.linearToEaseOut,
                                decoration: BoxDecoration(
                                    color: deletionIndex.value == index &&
                                            shouldShowDeletionUI.value
                                        ? Colors.red
                                        : isDarkMode.value
                                            ? Colors.white
                                            : const Color(0xff1d3f5e),
                                    borderRadius: BorderRadius.circular(17)),
                                child: Center(
                                    child: Text(
                                  deletionIndex.value == index &&
                                          shouldShowDeletionUI.value
                                      ? "delete folder"
                                      : bookmarkViewModel
                                          .value
                                          .bookmarkModel
                                          .value
                                          .folderName[index]["folder_name"],
                                  style: TextStyle(
                                      fontFamily: "SF-Pro",
                                      fontWeight: FontWeight.w900,
                                      fontSize: size.width * .041,
                                      color: isDarkMode.value
                                          ? Colors.black
                                          : Colors.white),
                                )),
                              ),
                            )),
                      );
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget listOfBookMarkVersesWidget(BookmarkViewModel bookmarkViewModel) {
    RxBool shouldShowDeletionUI = false.obs;
    RxInt deletionIndex = 0.obs, bookMarkFolderIndex = 0.obs, length = 0.obs;

    init() async {
      await bookmarkViewModel.fetchBookmarkFolderNames();
      length.value = bookmarkViewModel.bookmarkModel.value.folderName.length;
    }

    init();

    return Padding(
      padding: const EdgeInsets.all(21.0),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          color: isDarkMode.value ? const Color(0xff1d3f5e) : Colors.white,
          borderRadius: BorderRadius.circular(31),
        ),
        child: Column(
          children: [
            Obx(() => AnimatedPadding(
                  duration: const Duration(milliseconds: 555),
                  curve: Curves.linearToEaseOut,
                  padding: EdgeInsets.all(shouldShowDeletionUI.value ? 21 : 0),
                  child: GestureDetector(
                    onTap: () {
                      shouldShowDeletionUI.value = false;
                      deletionIndex.value = 0;
                    },
                    child: AnimatedContainer(
                      width: shouldShowDeletionUI.value ? size.width : 0,
                      height: shouldShowDeletionUI.value ? size.width * .11 : 0,
                      duration: const Duration(milliseconds: 555),
                      curve: Curves.linearToEaseOut,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(17)),
                      child: Center(
                        child: Text(
                          "cancel",
                          style: TextStyle(
                              fontFamily: "SF-Pro",
                              fontWeight: FontWeight.w900,
                              fontSize: size.width * .041,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )),
            const Padding(
              padding: EdgeInsets.fromLTRB(21, 21, 21, 21),
              child: Row(
                children: [
                  Icon(Icons.book),
                  Text(
                    "  all bookmark folders:",
                    style: TextStyle(
                        fontFamily: "SF-Pro", fontWeight: FontWeight.w900),
                  )
                ],
              ),
            ),
            Obx(() => Expanded(
                  child: ListView.builder(
                    itemCount: length.value,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 21, vertical: 5.5),
                        child: Obx(() => GestureDetector(
                              onLongPress: () {
                                deletionIndex.value = index;
                                shouldShowDeletionUI.value = true;
                                print("long pressed");
                              },
                              onTap: () async {
                                if (shouldShowDeletionUI.value) {
                                  await bookmarkViewModel.deleteData(
                                      bookmarkViewModel.bookmarkModel.value
                                              .folderName[deletionIndex.value]
                                          ["folder_name"]);
                                  shouldShowDeletionUI.value = false;
                                  deletionIndex.value = 0;
                                  init();
                                } else {
                                  Get.to(() => BookmarkVerses(
                                        bookmarkFolderName: bookmarkViewModel
                                            .bookmarkModel
                                            .value
                                            .folderName[index]["folder_name"],
                                        isDarkMode: isDarkMode,
                                      ));
                                }
                              },
                              child: AnimatedContainer(
                                width: size.width,
                                height: size.width * .11,
                                duration: const Duration(milliseconds: 555),
                                curve: Curves.linearToEaseOut,
                                decoration: BoxDecoration(
                                    color: deletionIndex.value == index &&
                                            shouldShowDeletionUI.value
                                        ? Colors.red
                                        : isDarkMode.value
                                            ? Colors.white
                                            : const Color(0xff1d3f5e),
                                    borderRadius: BorderRadius.circular(17)),
                                child: Center(
                                    child: Text(
                                  deletionIndex.value == index &&
                                          shouldShowDeletionUI.value
                                      ? "delete folder"
                                      : bookmarkViewModel.bookmarkModel.value
                                          .folderName[index]["folder_name"],
                                  style: TextStyle(
                                      fontFamily: "SF-Pro",
                                      fontWeight: FontWeight.w900,
                                      fontSize: size.width * .041,
                                      color: isDarkMode.value
                                          ? Colors.black
                                          : Colors.white),
                                )),
                              ),
                            )),
                      );
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget verseOptions(
      List<dynamic> folderNames,
      Rx<BookmarkViewModel> bookmarkViewModel,
      String arabicVerse,
      String englishVerse,
      int surah_id,
      int verse_id,
      int isSujoodVerse) {
    BookmarkViewModel bookmarkViewModel = Get.put(BookmarkViewModel());
    FavoriteVersesViewModel favoriteVersesViewModel =
        Get.put(FavoriteVersesViewModel());

    return Padding(
        padding: const EdgeInsets.all(21.0),
        child: Container(
            width: size.width,
            decoration: BoxDecoration(
              color: isDarkMode.value ? const Color(0xff1d3f5e) : Colors.white,
              borderRadius: BorderRadius.circular(31),
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Obx(
                () => Padding(
                    padding: const EdgeInsets.fromLTRB(21, 21, 21, 11),
                    child: GestureDetector(
                      onTap: () async {
                        Get.bottomSheet(addBookMarkWidget(
                            folderNames,
                            bookmarkViewModel.obs,
                            arabicVerse,
                            englishVerse,
                            surah_id,
                            verse_id,
                            isSujoodVerse));
                      },
                      child: AnimatedContainer(
                        width: size.width,
                        height: size.width * .11,
                        duration: const Duration(milliseconds: 555),
                        curve: Curves.linearToEaseOut,
                        decoration: BoxDecoration(
                            color: isDarkMode.value
                                ? Colors.white
                                : const Color(0xff1d3f5e),
                            borderRadius: BorderRadius.circular(17)),
                        child: Center(
                            child: Text(
                          "add to bookmarks",
                          style: TextStyle(
                              fontFamily: "SF-Pro",
                              fontWeight: FontWeight.w900,
                              fontSize: size.width * .041,
                              color: isDarkMode.value
                                  ? Colors.black
                                  : Colors.white),
                        )),
                      ),
                    )),
              ),
              Obx(
                () => Padding(
                    padding: const EdgeInsets.fromLTRB(21, 0, 21, 21),
                    child: GestureDetector(
                      onTap: () async {
                        await favoriteVersesViewModel.addVerseAsFavorite(
                            arabicVerse: arabicVerse,
                            englishVerse: englishVerse,
                            surah_id: surah_id,
                            verse_id: verse_id,
                            isSujoodVerse: isSujoodVerse);
                        Get.back();
                      },
                      child: AnimatedContainer(
                        width: size.width,
                        height: size.width * .11,
                        duration: const Duration(milliseconds: 555),
                        curve: Curves.linearToEaseOut,
                        decoration: BoxDecoration(
                            color: isDarkMode.value
                                ? Colors.white
                                : const Color(0xff1d3f5e),
                            borderRadius: BorderRadius.circular(17)),
                        child: Center(
                            child: Text(
                          "add to favorite verses",
                          style: TextStyle(
                              fontFamily: "SF-Pro",
                              fontWeight: FontWeight.w900,
                              fontSize: size.width * .041,
                              color: isDarkMode.value
                                  ? Colors.black
                                  : Colors.white),
                        )),
                      ),
                    )),
              )
            ])));
  }

  Widget settingsUI() {
    return Obx(() => Container(
          width: size.width,
          // height: size.width * 1.5,
          margin: const EdgeInsets.all(21),
          decoration: BoxDecoration(
              color: isDarkMode.value ? const Color(0xff1d3f5e) : Colors.white,
              borderRadius: BorderRadius.circular(31)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 355),
                  width: size.width,
                  padding: const EdgeInsets.all(17),
                  margin: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(41),
                      color: Colors.black38),
                  child: Column(
                    children: [
                      Text(
                        "arabic font size: ${fontSizeController.arabicFontSize.round()}",
                        style: const TextStyle(
                          height: 0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              fontSizeController.arabicFontSize.value -= 1;
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.setDouble(
                                  "arabicFontSize", fontSizeController.arabicFontSize.value);
                            },
                            child: Container(
                              width: size.width * .1,
                              height: size.width * .1,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1000)),
                              child: const Icon(
                                CupertinoIcons.minus,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                              width: size.width * .41,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(11.0),
                                  child: Text(
                                    "بِسْمِ اللهِ",
                                    style: TextStyle(
                                        height: 0,
                                        color: isDarkMode.value
                                            ? Colors.white
                                            : Colors.black,
                                        fontFamily:
                                            "Al Majeed Quranic Font_shiped",
                                        fontSize: fontSizeController.arabicFontSize.value),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )),
                          GestureDetector(
                            onTap: () async {
                              fontSizeController.arabicFontSize.value += 1;
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.setDouble(
                                  "arabicFontSize", fontSizeController.arabicFontSize.value);
                            },
                            child: Container(
                              width: size.width * .1,
                              height: size.width * .1,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1000)),
                              child: const Icon(
                                CupertinoIcons.plus,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 355),
                  width: size.width,
                  padding: const EdgeInsets.all(17),
                  margin: const EdgeInsets.fromLTRB(17, 0, 17, 17),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(41),
                      color: Colors.black38),
                  child: Column(
                    children: [
                      Text(
                        "english font size: ${fontSizeController.englishFontSize.round()}",
                        style: TextStyle(
                          height: 0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              fontSizeController.englishFontSize.value -= 1;
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.setDouble(
                                  "englishFontSize", fontSizeController.englishFontSize.value);
                            },
                            child: Container(
                              width: size.width * .1,
                              height: size.width * .1,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1000)),
                              child: const Icon(
                                CupertinoIcons.minus,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                              width: size.width * .41,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(11.0),
                                  child: Text(
                                    "In the name of ALLAH",
                                    style: TextStyle(
                                        height: 0,
                                        color: isDarkMode.value
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: fontSizeController.englishFontSize.value),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )),
                          GestureDetector(
                            onTap: () async {
                              fontSizeController.englishFontSize.value += 1;
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.setDouble(
                                  "englishFontSize", fontSizeController.englishFontSize.value);
                            },
                            child: Container(
                              width: size.width * .1,
                              height: size.width * .1,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1000)),
                              child: const Icon(
                                CupertinoIcons.plus,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
