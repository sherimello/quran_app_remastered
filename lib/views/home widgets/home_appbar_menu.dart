import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/views/home%20widgets/rounded_menu_buttons.dart';

import '../../controllers/animated_menu_icon_animation_controller.dart';
import '../general widgets/bottomsheet_UIs.dart';

class HomeAppbarMenu extends StatelessWidget {

  final BottomsheetUIs bottomsheetUIs;
  final bool shouldShowSurahInfo;
  final String surahName, verseNumber;

  const HomeAppbarMenu({super.key, required this.bottomsheetUIs, this.shouldShowSurahInfo = false, this.surahName = "", this.verseNumber = ""});

  @override
  Widget build(BuildContext context) {

    var size = Get.size;
    var appBarHeight = AppBar().preferredSize.height;
    AnimatedMenuIconAnimationController animatedMenuIconAnimationController =
    Get.put(AnimatedMenuIconAnimationController());
    BottomsheetUIs bottomsheetUIs = Get.put(BottomsheetUIs());

    return Obx(() => AnimatedPositioned(
      top: !animatedMenuIconAnimationController.isPlaying.value
          ? 0
          : 21,
      right: !animatedMenuIconAnimationController.isPlaying.value
          ? 0
          : 21,
      left: !animatedMenuIconAnimationController.isPlaying.value
          ? 0
          : 21,
      duration: const Duration(milliseconds: 555),
      curve: Curves.linearToEaseOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 555),
        curve: Curves.linearToEaseOut,
        width: size.width,
        height:
        !animatedMenuIconAnimationController.isPlaying.value
            ? appBarHeight
            : appBarHeight * 1.5,
        // height: !animatedMenuIconAnimationController.isPlaying.value ? appBarHeight : size.width,
        decoration: BoxDecoration(
            color: const Color(0xff1d3f5e),
            borderRadius: BorderRadius.circular(
                !animatedMenuIconAnimationController
                    .isPlaying.value
                    ? 0
                    : 45)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
                duration: const Duration(milliseconds: 555),
                curve: Curves.linearToEaseOut,
                top: 0,
                left: !animatedMenuIconAnimationController
                    .isPlaying.value
                    ? 0
                    : -size.width * .25,
                bottom: 0,
                child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 355),
                    curve: Curves.linearToEaseOut,
                    opacity: !animatedMenuIconAnimationController
                        .isPlaying.value
                        ? .15
                        : 0,
                    child: Image.asset(
                      "assets/images/headerDesignL.png",
                      fit: BoxFit.cover,
                      width: size.width * .25,
                    ))),
            AnimatedPositioned(
                duration: const Duration(milliseconds: 355),
                curve: Curves.linearToEaseOut,
                right: !animatedMenuIconAnimationController
                    .isPlaying.value
                    ? 0
                    : -size.width * .25,
                top: 0,
                bottom: 0,
                child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 355),
                    curve: Curves.linearToEaseOut,
                    opacity: !animatedMenuIconAnimationController
                        .isPlaying.value
                        ? .15
                        : 0,
                    child: Image.asset(
                      "assets/images/headerDesignR.png",
                      fit: BoxFit.cover,
                      width: size.width * .25,
                    ))),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 355),
              curve: Curves.linearToEaseOut,
              opacity: !animatedMenuIconAnimationController
                  .isPlaying.value
                  ? 1
                  : 0,
              child: shouldShowSurahInfo ?
              SizedBox(
                height: appBarHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(surahName,
                    style: const TextStyle(
                      fontFamily: "SF-Pro",
                      fontWeight: FontWeight.w900,
                      color: Colors.white
                    ),
                    ),
                    Text("total verses: $verseNumber",

                      style: const TextStyle(
                          fontFamily: "SF-Pro",
                          color: Colors.white
                      ),)
                  ],
                ),
              ) :
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/quran icon.png",
                  width: size.width * .081,
                  height: size.width * .081,
                  ),
                  Text(
                    "  al qur'an",
                    style: TextStyle(
                      // height: 0,
                        color: Colors.white,
                        fontFamily: "Bismillah Script",
                        fontWeight: FontWeight.w900,
                        fontSize: size.width * .059),
                  )
                ],
              ),
            ),
            Positioned(
                top: !animatedMenuIconAnimationController
                    .isPlaying.value
                    ? appBarHeight * .5 - size.width * .075 * .45
                    : appBarHeight * .75 -
                    size.width * .075 * .45,
                right: 21,
                child: GestureDetector(
                    onTap: () =>
                        animatedMenuIconAnimationController
                            .triggerMenuClick(),
                    child: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        size: size.width * .075,
                        color: Colors.white,
                        progress:
                        animatedMenuIconAnimationController
                            .controller.value))),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 755),
                curve: Curves.linearToEaseOut,
                opacity: animatedMenuIconAnimationController
                    .isPlaying.value
                    ? 1
                    : 0,
                child: SizedBox(
                  width: size.width - 63 - size.width * .075,
                  child: AbsorbPointer(
                    absorbing:
                    !animatedMenuIconAnimationController
                        .isPlaying.value,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundedMenuButtons(
                            iconData:
                            bottomsheetUIs.isDarkMode.value
                                ? Icons.dark_mode
                                : Icons.light_mode,
                            widget: bottomsheetUIs.themeList(),
                            isDarkMode:
                            bottomsheetUIs.isDarkMode),
                        RoundedMenuButtons(
                          iconData: Icons.bookmark,
                          widget: bottomsheetUIs.themeList(),
                          isDarkMode: bottomsheetUIs.isDarkMode,
                          isComingSoon: true,
                        ),
                        RoundedMenuButtons(
                          iconData: Icons.favorite_rounded,
                          widget: bottomsheetUIs.themeList(),
                          isDarkMode: bottomsheetUIs.isDarkMode,
                          isComingSoon: true,
                        ),
                        RoundedMenuButtons(
                          iconData: Icons.manage_search,
                          widget: bottomsheetUIs.themeList(),
                          isDarkMode: bottomsheetUIs.isDarkMode,
                          isComingSoon: true,
                        ),
                        RoundedMenuButtons(
                          iconData: Icons.info,
                          widget: bottomsheetUIs.aboutWidget(),
                          isDarkMode: bottomsheetUIs.isDarkMode,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
