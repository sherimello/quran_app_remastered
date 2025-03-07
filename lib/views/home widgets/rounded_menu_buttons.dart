import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/views/screens/favorite_verses.dart';
import 'package:quran_app/views/screens/search_verses.dart';

class RoundedMenuButtons extends StatelessWidget {
  final IconData iconData;
  final Widget widget;
  final RxBool isDarkMode;
  final bool isComingSoon;

  const RoundedMenuButtons(
      {super.key,
      required this.iconData,
      required this.widget,
      required this.isDarkMode,
      this.isComingSoon = false});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () =>
          iconData == Icons.manage_search ?
              Get.to(() => SearchVerses(isDarkMode: isDarkMode,)) :
          iconData == Icons.favorite_rounded ?
              Navigator.push(context, MaterialPageRoute(builder: (builder) => FavoriteVerses(isDarkMode: isDarkMode,))) :
          isComingSoon
              ? Get.snackbar(
                  "sorry!",
                  "feature will be active soon...",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: isDarkMode.value ? Colors.white : const Color(0xff1d3f5e),
                  colorText: isDarkMode.value ? Colors.black : Colors.white,
                  margin: const EdgeInsets.all(21),
                )
              : Get.bottomSheet(
                  widget,
                ),
          child: Container(
            decoration: BoxDecoration(
                color: isDarkMode.value ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(100)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(iconData),
            ),
          ),
        ));
  }
}
