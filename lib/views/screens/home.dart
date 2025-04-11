import 'package:flutter/cupertino.dart';
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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AnimatedMenuIconAnimationController
      animatedMenuIconAnimationController =
      Get.put(AnimatedMenuIconAnimationController());
  BottomsheetUIs bottomsheetUIs = Get.put(BottomsheetUIs(Get.size));
  final SettingsController settingsController = Get.put(SettingsController());

  RxBool searchClicked = false.obs;
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose(); // Dispose of the FocusNode
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = Get.size;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            SurahList(bottomsheetUIs: bottomsheetUIs),
            Container(
              width: size.width,
              height: MediaQuery.of(context).padding.top,
              color: const Color(0xff1d3f5e),
            ),
            Padding(
              padding:
              EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: HomeAppbarMenu(bottomsheetUIs: bottomsheetUIs),
            ),
            // AnimatedPositioned(
            //     right: 21,
            //     bottom: MediaQuery.of(context).padding.bottom,
            //     curve: Curves.easeInOut,
            //     duration: const Duration(milliseconds: 355),
            //     child: GestureDetector(
            //       onTap: () {
            //         searchClicked.value =
            //             !searchClicked.value; // Toggle searchClicked
            //         if (searchClicked.value) {
            //           WidgetsBinding.instance.addPostFrameCallback((_) {
            //             FocusScope.of(context).requestFocus(focusNode);
            //           });
            //         } else {
            //           FocusScope.of(context).unfocus();
            //         }
            //       },
            //       child: AnimatedContainer(
            //         duration: const Duration(milliseconds: 355),
            //         curve: Curves.easeInOut,
            //         width: searchClicked.value
            //             ? size.width - 42
            //             : size.width * .15,
            //         height: size.width * .15,
            //         decoration: BoxDecoration(
            //           color: searchClicked.value
            //               ? Colors.white
            //               : const Color(0xff1d3f5e),
            //           borderRadius: BorderRadius.circular(1000),
            //         ),
            //         child: Stack(
            //           alignment: Alignment.center,
            //           children: [
            //             AnimatedOpacity(
            //               duration: const Duration(milliseconds: 355),
            //               opacity: searchClicked.value ? 0 : 1,
            //               child: const Icon(CupertinoIcons.search),
            //             ),
            //             Visibility(
            //               visible: searchClicked.value,
            //               child: Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 21.0),
            //                 child: TextField(
            //                   focusNode: focusNode,
            //                   decoration: const InputDecoration(
            //                     hintText: "surah name...",
            //                     hintStyle: TextStyle(
            //                       color: Colors.black54
            //                     ),
            //                     border: InputBorder.none,
            //                     fillColor: Colors.transparent,
            //                   ),
            //                   style: TextStyle(
            //                     color: Colors.black,
            //                     fontWeight: FontWeight.w700
            //                   ),
            //                   cursorColor: Colors.black,
            //                   onSubmitted: (v) {
            //                     searchClicked.value = false;
            //                     FocusScope.of(context).unfocus();
            //                   },
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ))
          ],
        ),
      ),
    );
  }
}
