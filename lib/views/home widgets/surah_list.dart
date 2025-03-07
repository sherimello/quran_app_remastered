// import 'package:flexible_scrollbar/flexible_scrollbar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quran_app/data/surah_types.dart';
// import 'package:quran_app/view%20models/sujood_verse_view_model.dart';
// import 'package:quran_app/views/general%20widgets/bottomsheet_UIs.dart';
// import 'package:quran_app/views/home%20widgets/surah_type_text.dart';
// import 'package:quran_app/views/screens/surah_screen.dart';
//
// import '../../controllers/database_controller.dart';
// import '../../view models/surah_name_view_model.dart';
//
// class SurahList extends StatelessWidget {
//   final BottomsheetUIs bottomsheetUIs;
//
//   const SurahList({super.key, required this.bottomsheetUIs});
//
//   @override
//   Widget build(BuildContext context) {
//     DatabaseController databaseController = Get.put(DatabaseController());
//     SujoodVerseViewModel sujoodVerseViewModel = Get.put(SujoodVerseViewModel());
//     SurahNameViewModel surahNameViewModel = Get.put(SurahNameViewModel());
//
//     SurahTypes surahTypes = SurahTypes();
//     var appBarHeight = AppBar().preferredSize.height;
//     var size = Get.size;
//
//     RxBool searchClicked = false.obs;
//     FocusNode focusNode = FocusNode();
//     TextEditingController searchController = TextEditingController();
//
//     return Obx(() => Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 0),
//               child: RawScrollbar(
//                 trackVisibility: true,
//                 padding: EdgeInsets.only(top: appBarHeight),
//                 thickness: 5,
//                 thumbColor: const Color(0xff1d3f5e),
//                 radius: const Radius.circular(3.0),
//                 interactive: true,
//                 thumbVisibility: true,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: surahNameViewModel
//                       .surahNameModel.value.surahEnglishName.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: EdgeInsets.only(
//                         left: 17,
//                         right: 17,
//                         top: index == 0 ? appBarHeight + 15 : 6.5,
//                         bottom: 6.5,
//                       ),
//                       child: GestureDetector(
//                         onTap: () {
//                           Get.to(() => SurahScreen(
//                                 surahNumber: index + 1,
//                                 isDarkMode: bottomsheetUIs.isDarkMode,
//                                 bottomsheetUIs: bottomsheetUIs,
//                                 surahName:
//                                     "${surahNameViewModel.surahNameModel.value.surahEnglishName[index]["translation"]} (${surahNameViewModel.surahNameModel.value.surahArabicName[index]["translation"]})",
//                                 sujoodVerses: sujoodVerseViewModel
//                                     .getSujoodVerses(index + 1),
//                               ));
//                         },
//                         child: Container(
//                           width: size.width,
//                           color: Colors.transparent,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Stack(
//                                 alignment: Alignment.center,
//                                 children: [
//                                   Text(
//                                     "${index + 1}",
//                                     style: TextStyle(
//                                       fontSize: size.width * .025,
//                                       fontFamily: "SF-Pro",
//                                       fontWeight: FontWeight.w900,
//                                     ),
//                                   ),
//                                   Obx(() => Image.asset(
//                                         "assets/images/indexDesign.png",
//                                         width: size.width * .1,
//                                         height: size.width * .1,
//                                         color: bottomsheetUIs.isDarkMode.value
//                                             ? Colors.white
//                                             : const Color(0xff1d3f5e),
//                                       ))
//                                 ],
//                               ),
//                               const SizedBox(width: 21),
//                               Flexible(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                         surahNameViewModel.surahNameModel.value
//                                                 .surahEnglishName[index]
//                                             ["translation"],
//                                         style: TextStyle(
//                                           fontSize: size.width * .037,
//                                           fontFamily: "SF-Pro",
//                                           fontWeight: FontWeight.w900,
//                                         ),
//                                         softWrap: true,
//                                         overflow: TextOverflow.visible),
//                                     Text(
//                                       surahNameViewModel.surahNameModel.value
//                                               .surahArabicName[index]
//                                           ["translation"],
//                                       style: TextStyle(
//                                         fontFamily: 'Al_Mushaf',
//                                         fontSize: size.width * .037,
//                                         fontWeight: FontWeight.w900,
//                                       ),
//                                     ),
//                                     surahTypes.madani_surah.contains(index + 1)
//                                         ? const SurahTypeText(
//                                             surahType: "Madani Surah")
//                                         : surahTypes.disputed_types
//                                                 .contains(index + 1)
//                                             ? const SurahTypeText(
//                                                 surahType:
//                                                     "(?) Disputed Location")
//                                             : const SurahTypeText(
//                                                 surahType: "Makki Surah"),
//                                     sujoodVerseViewModel
//                                             .sujoodVerseModel.value.surahID
//                                             .contains(index + 1)
//                                         ? const Text(
//                                             "contains verse(s) of sujood",
//                                             style: TextStyle(
//                                               color: Colors.deepOrangeAccent,
//                                               fontFamily: "SF-Pro",
//                                               fontWeight: FontWeight.w900,
//                                             ),
//                                           )
//                                         : const SizedBox(),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             AnimatedPositioned(
//               right: 21,
//               bottom: MediaQuery.of(context).padding.bottom,
//               curve: Curves.easeInOut,
//               duration: const Duration(milliseconds: 355),
//               child: GestureDetector(
//                 onTap: () {
//
//                   // if(!searchClicked.value) {
//                   //   searchClicked.value = true;
//                   //   WidgetsBinding.instance.addPostFrameCallback((_) {
//                   //     FocusScope.of(context).requestFocus(focusNode);
//                   //   });
//                   // }
//
//                   // Toggle the searchClicked state
//                   searchClicked.value = !searchClicked.value;
//
//                   if (searchClicked.value) {
//                     Future.delayed(const Duration(milliseconds: 450), () {
//                       print(searchClicked.value);
//                     });
//                   } else {
//                     FocusScope.of(context).unfocus(); // Remove focus
//                     print(searchClicked.value);
//                   }
//                 },
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 355),
//                   curve: Curves.easeInOut,
//                   width:
//                       searchClicked.value ? size.width - 42 : size.width * .15,
//                   height: size.width * .15,
//                   decoration: BoxDecoration(
//                     color: searchClicked.value
//                         ? Colors.white
//                         : const Color(0xff1d3f5e),
//                     borderRadius: BorderRadius.circular(1000),
//                   ),
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       // Icon when collapsed
//                       AnimatedOpacity(
//                         duration: const Duration(milliseconds: 355),
//                         opacity: searchClicked.value ? 0 : 1,
//                         child: const Icon(CupertinoIcons.search,
//                             color: Colors.white),
//                       ),
//                       // TextField when expanded
//                       AnimatedOpacity(
//                         duration: const Duration(milliseconds: 355),
//                         opacity: searchClicked.value ? 1 : 0,
//                         child: Visibility(
//                           visible: searchClicked.value,
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 21.0),
//                             child: TextField(
//                               focusNode: focusNode,
//                               controller: searchController,
//                               decoration: const InputDecoration(
//                                 hintText: "Search Surah...",
//                                 hintStyle: TextStyle(color: Colors.black54),
//                                 border: InputBorder.none,
//                               ),
//                               style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                               cursorColor: Colors.black,
//                               onSubmitted: (value) {
//                                 // Handle submission
//                                 searchClicked.value = false;
//                                 searchController.clear();
//                                 FocusScope.of(context).unfocus();
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             // AnimatedPositioned(
//             //   right: 21,
//             //   bottom: MediaQuery.of(context).padding.bottom,
//             //   curve: Curves.easeInOut,
//             //   duration: const Duration(milliseconds: 355),
//             //   child: GestureDetector(
//             //     onTap: () {
//             //       if (searchClicked.value) {
//             //         // If search is already clicked, collapse and unfocus
//             //         searchClicked.value = false; // Collapse the search bar
//             //         FocusScope.of(context).unfocus(); // Remove focus from the TextField
//             //       } else {
//             //         // If search is not clicked, expand the search bar
//             //         searchClicked.value = true; // Expand the search bar
//             //         // Request focus after the UI has updated
//             //         WidgetsBinding.instance.addPostFrameCallback((_) {
//             //           FocusScope.of(context).requestFocus(focusNode);
//             //         });
//             //       }
//             //     },
//             //     child: AnimatedContainer(
//             //       duration: const Duration(milliseconds: 355),
//             //       curve: Curves.easeInOut,
//             //       width: searchClicked.value ? size.width - 42 : size.width * .15,
//             //       height: size.width * .15,
//             //       decoration: BoxDecoration(
//             //         color: searchClicked.value ? Colors.white : const Color(0xff1d3f5e),
//             //         borderRadius: BorderRadius.circular(1000),
//             //       ),
//             //       child: Stack(
//             //         alignment: Alignment.center,
//             //         children: [
//             //           AnimatedOpacity(
//             //             duration: const Duration(milliseconds: 355),
//             //             opacity: searchClicked.value ? 0 : 1,
//             //             child: const Icon(CupertinoIcons.search),
//             //           ),
//             //           Visibility(
//             //             visible: searchClicked.value,
//             //             child: Padding(
//             //               padding: const EdgeInsets.symmetric(horizontal: 21.0),
//             //               child: TextField(
//             //                 focusNode: focusNode,
//             //                 decoration: const InputDecoration(
//             //                   hintText: "surah name...",
//             //                   hintStyle: TextStyle(color: Colors.black54),
//             //                   border: InputBorder.none,
//             //                   fillColor: Colors.transparent,
//             //                 ),
//             //                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
//             //                 cursorColor: Colors.black,
//             //                 onSubmitted: (v) {
//             //                   if(searchClicked.value) {
//             //                     searchClicked.value = false; // Collapse the search bar
//             //                     // WidgetsBinding.instance.addPostFrameCallback((_) {
//             //                       FocusScope.of(context).unfocus(); // Remove focus from the TextField
//             //                     // });
//             //                   }
//             //                 },
//             //               ),
//             //             ),
//             //           ),
//             //         ],
//             //       ),
//             //     ),
//             //   ),
//             // )
//             // AnimatedPositioned(
//             //     right: 21,
//             //     bottom: MediaQuery.of(context).padding.bottom,
//             //     curve: Curves.easeInOut,
//             //     duration: const Duration(milliseconds: 355),
//             //     child: GestureDetector(
//             //       onTap: () {
//             //         // searchClicked.value = !(searchClicked.value);
//             //
//             //         searchClicked.value = true;
//             //         print(searchClicked.value);
//             //         if (searchClicked.value) {
//             //           WidgetsBinding.instance.addPostFrameCallback((_) {
//             //           FocusScope.of(context).requestFocus(focusNode); // Request focus after UI update
//             //         });
//             //           // If search is already clicked, unfocus and collapse
//             //           // searchClicked.value = false; // Collapse the search bar
//             //         }
//             //         // else {
//             //         //   // If search is not clicked, expand the search bar and request focus
//             //         //   // searchClicked.value = true; // Expand the search bar
//             //         //   FocusScope.of(context).unfocus(); // Remove focus from the TextField
//             //         //
//             //         // }
//             //       },
//             //       child: AnimatedContainer(
//             //         duration: const Duration(milliseconds: 355),
//             //         curve: Curves.easeInOut,
//             //         width: searchClicked.value
//             //             ? size.width - 42
//             //             : size.width * .15,
//             //         height: size.width * .15,
//             //         decoration: BoxDecoration(
//             //           color: searchClicked.value
//             //               ? Colors.white
//             //               : const Color(0xff1d3f5e),
//             //           borderRadius: BorderRadius.circular(1000),
//             //         ),
//             //         child: Stack(
//             //           alignment: Alignment.center,
//             //           children: [
//             //             AnimatedOpacity(
//             //               duration: const Duration(milliseconds: 355),
//             //               opacity: searchClicked.value ? 0 : 1,
//             //               child: const Icon(CupertinoIcons.search),
//             //             ),
//             //             Visibility(
//             //               visible: searchClicked.value,
//             //               child: Padding(
//             //                 padding: const EdgeInsets.symmetric(horizontal: 21.0),
//             //                 child: TextField(
//             //                   focusNode: focusNode,
//             //                   decoration: const InputDecoration(
//             //                     hintText: "surah name...",
//             //                     hintStyle: TextStyle(
//             //                         color: Colors.black54
//             //                     ),
//             //                     border: InputBorder.none,
//             //                     fillColor: Colors.transparent,
//             //                   ),
//             //                   style: const TextStyle(
//             //                       color: Colors.black,
//             //                       fontWeight: FontWeight.w700
//             //                   ),
//             //                   cursorColor: Colors.black,
//             //                   // onSubmitted: (v) {
//             //                   //   searchClicked.value = false;
//             //                   //   print(searchClicked.value);
//             //                   //   FocusScope.of(context).unfocus();
//             //                   // },
//             //                 ),
//             //               ),
//             //             ),
//             //           ],
//             //         ),
//             //       ),
//             //     ))
//           ],
//         ));
//   }
// }

import 'package:flexible_scrollbar/flexible_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/data/surah_types.dart';
import 'package:quran_app/view%20models/sujood_verse_view_model.dart';
import 'package:quran_app/views/general%20widgets/bottomsheet_UIs.dart';
import 'package:quran_app/views/home%20widgets/surah_type_text.dart';
import 'package:quran_app/views/screens/surah_screen.dart';

import '../../controllers/database_controller.dart';
import '../../view models/surah_name_view_model.dart';

class SurahList extends StatelessWidget {
  final BottomsheetUIs bottomsheetUIs;

  const SurahList({super.key, required this.bottomsheetUIs});

  @override
  Widget build(BuildContext context) {
    DatabaseController databaseController = Get.put(DatabaseController());
    SujoodVerseViewModel sujoodVerseViewModel = Get.put(SujoodVerseViewModel());
    SurahNameViewModel surahNameViewModel = Get.put(SurahNameViewModel());

    SurahTypes surahTypes = SurahTypes();
    var appBarHeight = AppBar().preferredSize.height;
    var size = Get.size;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Obx(() {
            if (surahNameViewModel.surahNameModel.value.surahEnglishName.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }
            return RawScrollbar(
              trackVisibility: true,
              padding: EdgeInsets.only(top: appBarHeight),
              thickness: 5,
              thumbColor: const Color(0xff1d3f5e),
              radius: const Radius.circular(3.0),
              interactive: true,
              thumbVisibility: true,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: surahNameViewModel.surahNameModel.value.surahEnglishName.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 17,
                      right: 17,
                      top: index == 0 ? appBarHeight + 15 : 6.5,
                      bottom: 6.5,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => SurahScreen(
                          surahNumber: index + 1,
                          isDarkMode: bottomsheetUIs.isDarkMode,
                          bottomsheetUIs: bottomsheetUIs,
                          surahName:
                          "${surahNameViewModel.surahNameModel.value.surahEnglishName[index]["translation"]} (${surahNameViewModel.surahNameModel.value.surahArabicName[index]["translation"]})",
                          sujoodVerses: sujoodVerseViewModel.getSujoodVerses(index + 1),
                        ));
                      },
                      child: Container(
                        width: size.width,
                        color: Colors.transparent,
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
                                    fontSize: size.width * .025,
                                    fontFamily: "SF-Pro",
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Obx(() => Image.asset(
                                  "assets/images/indexDesign.png",
                                  width: size.width * .1,
                                  height: size.width * .1,
                                  color: bottomsheetUIs.isDarkMode.value
                                      ? Colors.white
                                      : const Color(0xff1d3f5e),
                                ))
                              ],
                            ),
                            const SizedBox(width: 21),
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      surahNameViewModel.surahNameModel.value.surahEnglishName[index]["translation"],
                                      style: TextStyle(
                                        fontSize: size.width * .037,
                                        fontFamily: "SF-Pro",
                                        fontWeight: FontWeight.w900,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.visible),
                                  Text(
                                    surahNameViewModel.surahNameModel.value.surahArabicName[index]["translation"],
                                    style: TextStyle(
                                      fontFamily: 'Al_Mushaf',
                                      fontSize: size.width * .037,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  surahTypes.madani_surah.contains(index + 1)
                                      ? const SurahTypeText(surahType: "Madani Surah")
                                      : surahTypes.disputed_types.contains(index + 1)
                                      ? const SurahTypeText(surahType: "(?) Disputed Location")
                                      : const SurahTypeText(surahType: "Makki Surah"),
                                  sujoodVerseViewModel.sujoodVerseModel.value.surahID.contains(index + 1)
                                      ? const Text(
                                    "contains verse(s) of sujood",
                                    style: TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontFamily: "SF-Pro",
                                      fontWeight: FontWeight.w900,
                                    ),
                                  )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ),
        _SearchBar(bottomsheetUIs: bottomsheetUIs, surahNames: surahNameViewModel
            .surahNameModel.value.surahEnglishName.map((surah) => surah["translation"] as String).toList(),),
      ],
    );
  }
}

class _SearchBar extends StatefulWidget {
  final BottomsheetUIs bottomsheetUIs;
  final List<String> surahNames;

  const _SearchBar({required this.bottomsheetUIs, required this.surahNames});

  @override
  __SearchBarState createState() => __SearchBarState();
}

class __SearchBarState extends State<_SearchBar> {
  final FocusNode _focusNode = FocusNode();
  bool _searchClicked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = Get.size;

    return AnimatedPositioned(
      right: 21,
      bottom: MediaQuery.of(context).padding.bottom + 21,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 355),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _searchClicked = !_searchClicked;
          });

          if (_searchClicked) {
            // Delay focus request to ensure UI has updated
            Future.delayed(const Duration(milliseconds: 50), () {
              FocusScope.of(context).requestFocus(_focusNode);
            });
          } else {
            FocusScope.of(context).unfocus();
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 355),
          curve: Curves.easeInOut,
          width: _searchClicked ? size.width - 42 : size.width * .15,
          height: size.width * .15,
          decoration: BoxDecoration(
            color: _searchClicked ? Colors.white : const Color(0xff1d3f5e),
            borderRadius: BorderRadius.circular(1000),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Icon when collapsed
              AnimatedOpacity(
                duration: const Duration(milliseconds: 355),
                opacity: _searchClicked ? 0 : 1,
                child: const Icon(CupertinoIcons.search, color: Colors.white),
              ),
              // Autocomplete when expanded
              AnimatedOpacity(
                duration: const Duration(milliseconds: 355),
                opacity: _searchClicked ? 1 : 0,
                child: Visibility(
                  visible: _searchClicked,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21.0),
                    child: Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<String>.empty();
                        }
                        return widget.surahNames.where((surah) {
                          return surah
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (String selection) {
                        print('You selected $selection');
                        setState(() {
                          _searchClicked = false;
                        });
                        FocusScope.of(context).unfocus();
                      },
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted) {
                        return TextField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          decoration: const InputDecoration(
                            hintText: 'Search Surah...',
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                          cursorColor: Colors.black,
                          onSubmitted: (value) {
                            setState(() {
                              _searchClicked = false;
                            });
                            FocusScope.of(context).unfocus();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}