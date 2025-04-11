// lib/views/home widgets/surah_list.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/controllers/surah_search_controller.dart'; // Ensure this path is correct
import 'package:quran_app/data/surah_types.dart';                     // Ensure this path is correct
import 'package:quran_app/view%20models/sujood_verse_view_model.dart';  // Ensure this path is correct
import 'package:quran_app/view%20models/surah_name_view_model.dart';    // Ensure this path is correct
import 'package:quran_app/views/general%20widgets/bottomsheet_UIs.dart'; // Ensure this path is correct
import 'package:quran_app/views/home%20widgets/surah_type_text.dart';
import 'package:quran_app/views/screens/surah_screen.dart';           // Ensure this path is correct


class _SearchBar extends StatefulWidget {
  final BottomsheetUIs bottomsheetUIs;

  const _SearchBar({required this.bottomsheetUIs});

  @override
  __SearchBarState createState() => __SearchBarState();
}

class __SearchBarState extends State<_SearchBar> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();
  // Find the SINGLE search/filter controller instance already put by SurahList
  final SurahSearchController _searchController = Get.find<SurahSearchController>();

  // Local UI state for the animation ONLY
  bool _searchClicked = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);

    // Listen to controller query changes to clear local text if needed
    ever(_searchController.searchQuery, (String query) {
      if (query.isEmpty && _textController.text.isNotEmpty && mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _textController.clear();
        });
      }
    });
  }

  void _onFocusChange() {
    if (!mounted) return;
    if (!_focusNode.hasFocus && _searchClicked) {
      // Collapse UI if focus is lost while it was expanded
      _toggleSearchUI(expand: false);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  // Manages the UI animation and focus
  void _toggleSearchUI({required bool expand}) {
    if (_searchClicked == expand) return; // No change needed

    setState(() { _searchClicked = expand; });

    if (_searchClicked) { // Expanding
      Future.delayed(const Duration(milliseconds: 50), () {
        if (mounted) FocusScope.of(context).requestFocus(_focusNode);
      });
    } else { // Collapsing
      _searchController.clearSearch(); // Clear filter in controller
      // _textController is cleared via listener to searchQuery now
      if (mounted) FocusScope.of(context).unfocus();
    }
  }


  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return AnimatedPositioned(
      right: 21,
      bottom: bottomPadding + 21, // Consistent spacing from true bottom
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 355),
      child: Obx(() => AnimatedContainer(
        duration: const Duration(milliseconds: 355),
        curve: Curves.easeInOut,
        width: _searchClicked ? size.width - 42 : size.width * .15,
        height: size.width * .15, // Fixed height for the search bar itself
        decoration: BoxDecoration(
          color: _searchClicked
              ? (widget.bottomsheetUIs.isDarkMode.value ? Colors.grey[850]! : Colors.white) // Dark mode aware BG
              : const Color(0xff1d3f5e),
          borderRadius: BorderRadius.circular(1000), // Circular when collapsed
          boxShadow: _searchClicked
              ? [ BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 6, spreadRadius: 1) ]
              : [],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // --- Search Icon (acts as expand button) ---
            AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: _searchClicked ? 0 : 1,
              child: IgnorePointer( // Prevent tap when hidden
                ignoring: _searchClicked,
                child: Center( // Center the icon
                  child: IconButton(
                    icon: const Icon(CupertinoIcons.search, color: Colors.white),
                    onPressed: () => _toggleSearchUI(expand: true),
                    tooltip: 'Search Surahs',
                  ),
                ),
              ),
            ),

            // --- Text Field & Clear Button ---
            AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              // delay: Duration(milliseconds: _searchClicked ? 100 : 0),
              opacity: _searchClicked ? 1 : 0,
              child: Visibility( // Use visibility controlled by animation state
                visible: _searchClicked,
                // No need for maintainState usually if opacity handles it
                child: Padding(
                  padding: const EdgeInsets.only(left: 21.0, right: 45.0), // Space for clear button
                  child: Obx(()=> TextField( // Obx for dark mode style changes
                    controller: _textController,
                    focusNode: _focusNode,
                    onChanged: _searchController.updateSearchQuery, // Update controller's query
                    decoration: InputDecoration(
                      hintText: 'Search Surah or Number...',
                      hintStyle: TextStyle(
                          color: widget.bottomsheetUIs.isDarkMode.value ? Colors.grey[400] : Colors.black54,
                          fontSize: 15 // Consistent hint size
                      ),
                      border: InputBorder.none, // No underline
                      isDense: true,
                      // Center the text vertically - adjust padding as needed
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    style: TextStyle( // Style for the actual input text
                      color: widget.bottomsheetUIs.isDarkMode.value ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                    cursorColor: widget.bottomsheetUIs.isDarkMode.value ? Colors.tealAccent : Colors.black, // Customize cursor
                    textInputAction: TextInputAction.search,
                    onTap: (){ // Ensure tapping field when collapsed still expands it
                      if(!_searchClicked) _toggleSearchUI(expand: true);
                    },
                    onSubmitted: (value) {
                      FocusScope.of(context).unfocus(); // Hide keyboard on submit
                      // Optionally collapse: _toggleSearchUI(expand: false);
                    },
                  )),
                ),
              ),
            ),

            // --- Clear Button ---
            Positioned(
              right: 0, // Align to the right
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                // Show only if expanded AND text is not empty
                opacity: _searchClicked && _textController.text.isNotEmpty ? 1 : 0,
                child: Visibility(
                  // Control visibility based on state too
                  visible: _searchClicked && _textController.text.isNotEmpty,
                  child: IconButton(
                    icon: Icon(Icons.clear_rounded, // Use a rounded clear icon
                        size: 22,
                        color: widget.bottomsheetUIs.isDarkMode.value ? Colors.grey[400] : Colors.black54
                    ),
                    onPressed: _isExpanded ? () { // Check expansion state before allowing tap
                      _textController.clear(); // Clear local field FIRST
                      _searchController.clearSearch(); // THEN clear controller state
                    } : null,
                    tooltip: 'Clear Search',
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
  // Helper getter to check expansion state clearly
  bool get _isExpanded => _searchClicked;
}


class SurahList extends StatelessWidget {
  final BottomsheetUIs bottomsheetUIs;

  const SurahList({super.key, required this.bottomsheetUIs});

  @override
  Widget build(BuildContext context) {
    // --- Initialize/Find Dependencies ---
    // Ensure ViewModels are ready (use Get.find() if already put elsewhere)
    final SujoodVerseViewModel sujoodVerseViewModel = Get.put(SujoodVerseViewModel());
    final SurahNameViewModel surahNameViewModel = Get.put(SurahNameViewModel());
    // Initialize the Controller that manages search/filter state
    final SurahSearchController searchController = Get.put(SurahSearchController());

    final SurahTypes surahTypes = SurahTypes();
    final appBarHeight = AppBar().preferredSize.height;
    final size = Get.size;

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        // --- Optional: Hide keyboard on scroll ---
        if (scrollNotification is ScrollStartNotification) {
          // Check if search bar has focus before dismissing keyboard
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (currentFocus.hasPrimaryFocus || currentFocus.hasFocus) {
            currentFocus.unfocus(); // Dismiss keyboard when list scrolls
          }
        }
        return false; // Allow notification to bubble up
      },
      child: Stack(
        children: [
          // --- Background List View ---
          Padding(
            padding: EdgeInsets.only(top: appBarHeight),
            child: Obx(() { // List reacts to filter changes AND dark mode
              // 1. Handle Loading State
              if (searchController.isLoading.value) {
                return Center(child: CircularProgressIndicator(
                    color: bottomsheetUIs.isDarkMode.value ? Colors.white70 : const Color(0xff1d3f5e)
                ));
              }

              // 2. Handle "No Results" during search
              if (searchController.searchQuery.isNotEmpty && searchController.filteredSurahs.isEmpty) {
                return Padding(
                    padding: EdgeInsets.only(top: appBarHeight + 30, left: 20, right: 20),
                    child: Center(child: Text(
                      "No Surahs found matching '${searchController.searchQuery.value}'.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: bottomsheetUIs.isDarkMode.value ? Colors.grey[400] : Colors.grey[600]),
                    ))
                );
              }

              // 3. Handle Empty List (initial or after failed load)
              if (searchController.filteredSurahs.isEmpty) {
                return Center(child: Text(
                    "Could not load Surah list.",
                    style: TextStyle(fontSize: 16, color: bottomsheetUIs.isDarkMode.value ? Colors.grey[400] : Colors.grey[600])
                ));
              }

              // --- 4. Display the Filtered List ---
              return Scrollbar( // Using standard Scrollbar
                thickness: 5,
                radius: const Radius.circular(3.0),
                child: ListView.builder(
                  // Calculate appropriate padding
                  padding: EdgeInsets.only(
                    // Enough space at the top for a potentially fixed header/AppBar area
                    top: appBarHeight + 10,
                    // Enough space at the bottom so the floating search bar doesn't overlap the last item
                    bottom: (size.width * 0.15) + 40, // Search bar height + extra space
                    left: 0,
                    right: 0,
                  ),
                  itemCount: searchController.filteredSurahs.length,
                  itemBuilder: (context, index) {
                    final surahInfo = searchController.filteredSurahs[index];
                    final originalSurahNumber = surahInfo.originalIndex + 1;

                    // Build the list item widget
                    return Padding(
                      padding: const EdgeInsets.only(left: 17, right: 17, top: 4.0, bottom: 4.0), // Reduced vertical padding
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          FocusScope.of(context).unfocus(); // Dismiss keyboard on tap
                          Get.to(() => SurahScreen(
                            surahNumber: originalSurahNumber,
                            isDarkMode: bottomsheetUIs.isDarkMode,
                            bottomsheetUIs: bottomsheetUIs,
                            surahName: "${surahInfo.englishName} (${surahInfo.arabicName})",
                            sujoodVerses: sujoodVerseViewModel.getSujoodVerses(originalSurahNumber),
                          ),
                              transition: Transition.rightToLeftWithFade,
                              duration: const Duration(milliseconds: 400)
                          );
                        },
                        child: Container(
                          width: size.width,
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5), // Item padding
                          decoration: BoxDecoration(
                            // Subtle background difference or keep transparent
                            // color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // --- Index Number Stack ---
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Obx(() => Text(
                                    "$originalSurahNumber",
                                    style: TextStyle(
                                      fontSize: size.width * .025,
                                      fontFamily: "SF-Pro",
                                      fontWeight: FontWeight.w900,
                                      color: bottomsheetUIs.isDarkMode.value ? Colors.white70 : Colors.black54,
                                    ),
                                  )),
                                  Obx(() => Image.asset(
                                    "assets/images/indexDesign.png",
                                    width: size.width * .1,
                                    height: size.width * .1,
                                    color: bottomsheetUIs.isDarkMode.value ? Colors.white : const Color(0xff1d3f5e),
                                    errorBuilder: (c, o, s) => Icon(Icons.error_outline, size: size.width * .08), // Error placeholder
                                  ))
                                ],
                              ),
                              const SizedBox(width: 11),

                              // --- Surah Details Column ---
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx(()=> Text( // English Name
                                      surahInfo.englishName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: size.width * .038, // Slightly larger
                                        fontFamily: "SF-Pro",
                                        height: 0,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w900,
                                        color: bottomsheetUIs.isDarkMode.value ? Colors.white : Colors.black87,
                                      ),
                                    )),
                                    Row(
                                      spacing: 7,
                                      children: [
                                        Obx(()=> Text( // Arabic Name
                                          surahInfo.arabicName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'qalammajeed3', // Ensure this font is available
                                            fontSize: size.width * .035, // Match English size
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 0,
                                            height: 0,
                                            // color: const Color(0xff4ea5f4),
                                            color: bottomsheetUIs.isDarkMode.value ? const Color(0xff4ea5f4) : const Color(0xff1d3f5e),
                                          ),
                                        )),
                                        Obx(()=> surahTypes.madani_surah.contains(originalSurahNumber) // Obx wrapper if needed, but value is static
                                            ? SurahTypeText(surahType: "Madani", isDarkMode: bottomsheetUIs.isDarkMode.value)
                                            : surahTypes.disputed_types.contains(originalSurahNumber)
                                            ? SurahTypeText(surahType: "Disputed (?)", isDarkMode: bottomsheetUIs.isDarkMode.value)
                                            : SurahTypeText(surahType: "Makki", isDarkMode: bottomsheetUIs.isDarkMode.value)),
                                      ],
                                    ),
                                    const SizedBox(height: 0),

                                    // --- Type & Sujood Info Row ---
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Sujood indicator
                                        if (sujoodVerseViewModel.sujoodVerseModel.value.surahID.contains(originalSurahNumber))
                                          const Padding(
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: Text("contains verse(s) of prostration",
                                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13, height: 0),)
                                          ),
                                      ],
                                    ),
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

          // --- Floating Search Bar Widget (using restored _SearchBar) ---
          _SearchBar(bottomsheetUIs: bottomsheetUIs), // Placed last to be on top
        ],
      ),
    );
  }
}