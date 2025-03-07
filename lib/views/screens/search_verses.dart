import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/view%20models/sujood_verse_view_model.dart';
import 'package:quran_app/view%20models/verseSearchViewModel.dart';
import 'package:quran_app/views/general%20widgets/highlighted_text.dart';

class SearchVerses extends StatelessWidget {
  final RxBool isDarkMode;

  const SearchVerses({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var appBarHeight = AppBar().preferredSize.height;
    var statusBarHeight = MediaQuery.of(context).padding.top;
    SujoodVerseViewModel sujoodVerseViewModel = Get.put(SujoodVerseViewModel());

    TextEditingController searchTextEditingController = TextEditingController();
    VerseSearchViewModel verseSearchViewModel = Get.put(VerseSearchViewModel());

    return Obx(() => Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [

            Padding(
              padding: EdgeInsets.only(top:  appBarHeight * 1.3 + 42),
              child: RawScrollbar(
                child: ListView.builder(
                    itemCount: verseSearchViewModel.searchVerseModel.value.englishVerseInfo.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                            21,
                            index == 0 ? 0 : 13.5,
                            21,
                            13.5),
                        child: Column(
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
                                            verseSearchViewModel.searchVerseModel.value.arabicVerseInfo[index]["text"] ?? "",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                fontSize: size.width * 0.061,
                                                fontWeight: FontWeight.w500,
                                                fontFamily:
                                                "Al_Mushaf"),
                                          ),
                                          sujoodVerseViewModel.sujoodVerseModel.value.surahID.contains(verseSearchViewModel.searchVerseModel.value.englishVerseInfo[index]["surah_id"])
                                              && sujoodVerseViewModel.sujoodVerseModel.value.verseID.contains(verseSearchViewModel.searchVerseModel.value.englishVerseInfo[index]["verse_id"]) ? SizedBox(
                                            height: size.width * .025,
                                          ) : const SizedBox(),
                                          sujoodVerseViewModel.sujoodVerseModel.value.surahID.contains(verseSearchViewModel.searchVerseModel.value.englishVerseInfo[index]["surah_id"])
                                              && sujoodVerseViewModel.sujoodVerseModel.value.verseID.contains(verseSearchViewModel.searchVerseModel.value.englishVerseInfo[index]["verse_id"]) ?const Text(
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
                                          Obx(() => RichText(
                                            textAlign: TextAlign.start,
                                            text: TextSpan(
                                              children: HighlightedText().highlightSearchedText(
                                                "${verseSearchViewModel.searchVerseModel.value.englishVerseInfo[index]["text"]} [${verseSearchViewModel.searchVerseModel.value.englishVerseInfo[index]["surah_id"]}:${verseSearchViewModel.searchVerseModel.value.englishVerseInfo[index]["verse_id"]}]" ?? "",
                                                searchTextEditingController.text, // Pass the searched keyword here
                                                isDarkMode.value,
                                              ),
                                              style: const TextStyle(
                                                fontFamily: "SF-Pro",
                                                fontWeight: FontWeight.w900,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ))
                                          // Obx(() => Text(
                                          //   verseSearchViewModel.searchVerseModel.value.englishVerseInfo[index]["text"] ?? "",
                                          //   textAlign: TextAlign.start,
                                          //   style: TextStyle(
                                          //       fontFamily: "SF-Pro",
                                          //       color: isDarkMode.value
                                          //           ? Colors.white
                                          //           .withOpacity(.35)
                                          //           : const Color(0xff1d3f5e)
                                          //           .withOpacity(.55),
                                          //       fontWeight: FontWeight.w900,
                                          //       fontStyle: FontStyle.italic),
                                          // ))
                                          // SizedBox(height: size.width * .055,),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      );
                    }),
              ),
            ),
            // ListView.builder(
            //     itemCount: verseSearchViewModel.searchVerseModel.value.englishVerseInfo.length,
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         title: Text(verseSearchViewModel.searchVerseModel.value.englishVerseInfo[index]["text"]),
            //       );
            //     }),
            Positioned(
              top: statusBarHeight + 21,
              left: 21,
              right: 21,
              child: Container(
                width: size.width,
                height: appBarHeight * 1.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: isDarkMode.value ? Colors.white : const Color(0xff1d3f5e)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width - 42 - 21 - appBarHeight * 1.3,
                      height: appBarHeight * 1.3 - 14,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000),
                          color: isDarkMode.value ? const Color(0xff1d3f5e) : Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17.0),
                        child: Center(
                          child: TextField(
                            controller: searchTextEditingController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "keyword..."
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        verseSearchViewModel.fetchVersesByKeyword(keyword: searchTextEditingController.text);
                      },
                      child: Container(
                        width: appBarHeight * 1.3 - 14,
                        height: appBarHeight * 1.3 - 14,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1000),
                            color: isDarkMode.value ? const Color(0xff1d3f5e) : Colors.white
                        ),
                        child: const Center(child: Icon(Icons.manage_search)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: size.width,
              height: statusBarHeight,
              color: const Color(0xff1d3f5e),
            )
          ],
        ),
      ),
    ));
  }
}
