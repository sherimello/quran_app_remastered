import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          onTap: () => isComingSoon
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
