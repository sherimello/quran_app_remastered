import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomsheetUIs extends GetxController {
  var size = Get.size;
  RxBool isDarkMode = false.obs;

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
                  Padding(padding: const EdgeInsets.only(top: 21),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_rounded, color: isDarkMode.value ? Colors.white : const Color(0xff1d3f5e),),
                      Text("  about",
                      style: TextStyle(
                        fontFamily: "SF-Pro",
                        fontWeight: FontWeight.w900,
                        fontSize: size.width * .055,
                        color: isDarkMode.value ? Colors.white : const Color(0xff1d3f5e)
                      ),
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
                          color: isDarkMode.value ? Colors.white : const Color(0xff1d3f5e),
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
}
