import 'package:get/get.dart';
import 'package:quran_app/view%20models/surah_name_view_model.dart';
import 'package:flutter/foundation.dart'; // for kDebugMode

// Define SurahInfo data class (Essential for linking filtered item back to original)
class SurahInfo {
  final int originalIndex; // Store the original 0-based index
  final Map<String, dynamic> englishNameData;
  final Map<String, dynamic> arabicNameData;

  SurahInfo({
    required this.originalIndex,
    required this.englishNameData,
    required this.arabicNameData,
  });

  // Helper getters for easy access
  String get englishName => englishNameData['translation'] as String? ?? '';
  String get arabicName => arabicNameData['translation'] as String? ?? '';
  String get englishTransliteration => englishNameData['transliteration'] as String? ?? '';

  // Method to check if this Surah matches a query (case-insensitive)
  bool matchesQuery(String query) {
    if (query.isEmpty) {
      return true; // Show all if query is empty
    }
    final lowerQuery = query.toLowerCase();
    // Check English Name, Transliteration, AND maybe Surah number
    return englishName.toLowerCase().contains(lowerQuery) ||
        arabicName.contains(query) || // Direct Arabic comparison (might need improvement)
        englishTransliteration.toLowerCase().contains(lowerQuery) ||
        (originalIndex + 1).toString() == query; // Allow searching by Surah number
  }
}


class SurahSearchController extends GetxController {
  // Find VM instance instead of putting - ASSUMES VM is put() elsewhere earlier
  final SurahNameViewModel _surahNameViewModel = Get.find<SurahNameViewModel>();

  final RxString searchQuery = ''.obs;
  final RxList<SurahInfo> allSurahs = <SurahInfo>[].obs; // Holds ALL SurahInfo objects
  final RxList<SurahInfo> filteredSurahs = <SurahInfo>[].obs; // Holds ONLY filtered results
  final RxBool isLoading = true.obs; // Track initial loading of surah names

  @override
  void onInit() {
    super.onInit();
    // Listen for when the view model's data is ready
    // Using once() might be sufficient if data loads only once
    // worker = ever(_surahNameViewModel.surahNameModel, (_) => _initializeSurahLists());
    // Or react to a specific loading state in the ViewModel if it exists
    // If the ViewModel data might already be present, try initializing immediately too
    if (_surahNameViewModel.surahNameModel.value.surahEnglishName.isNotEmpty) {
      _initializeSurahLists();
    } else {
      // Use a listener that triggers once data is loaded
      once(_surahNameViewModel.surahNameModel, (_) => _initializeSurahLists(), condition: () => _surahNameViewModel.surahNameModel.value.surahEnglishName.isNotEmpty);
      // Fallback timeout if data never loads?
    }

    // Reactively filter whenever the search query changes
    // Debounce prevents filtering on every single key press
    debounce(searchQuery, (_) => _filterSurahs(), time: const Duration(milliseconds: 300));
  }

  void _initializeSurahLists() {
    isLoading.value = true; // Start loading indicator
    if (_surahNameViewModel.surahNameModel.value.surahEnglishName.isEmpty) {
      if(kDebugMode) print("Initialize Failed: ViewModel data is empty.");
      isLoading.value = false;
      return;
    }

    final englishNames = _surahNameViewModel.surahNameModel.value.surahEnglishName;
    final arabicNames = _surahNameViewModel.surahNameModel.value.surahArabicName;

    if (englishNames.length != arabicNames.length) {
      if(kDebugMode) print("Initialize Failed: List lengths mismatch!");
      isLoading.value = false;
      return;
    }

    final List<SurahInfo> tempList = [];
    for (int i = 0; i < englishNames.length; i++) {
      tempList.add(SurahInfo(
        originalIndex: i,
        englishNameData: englishNames[i],
        arabicNameData: arabicNames[i],
      ));
    }
    allSurahs.assignAll(tempList);
    _filterSurahs(); // Perform initial filter (shows all)
    isLoading.value = false; // Mark loading complete
    if(kDebugMode) print("Initialized Controller with ${allSurahs.length} surahs.");
  }


  void updateSearchQuery(String query) {
    // Update the reactive searchQuery. The debounce listener will trigger filtering.
    searchQuery.value = query.trim();
  }

  void _filterSurahs() {
    final query = searchQuery.value;
    if (query.isEmpty) {
      // If query is empty, show all surahs
      filteredSurahs.assignAll(allSurahs);
    } else {
      // Otherwise, apply the filter
      filteredSurahs.assignAll(
          allSurahs.where((surahInfo) => surahInfo.matchesQuery(query)).toList());
    }
    if(kDebugMode) print("Filtered Surahs (${filteredSurahs.length}) for query: '$query'");
  }

  // Clear search query and show all Surahs again
  void clearSearch() {
    if (searchQuery.value.isNotEmpty) {
      searchQuery.value = ''; // Setting this triggers the debounce/filter listener
    }
  }
}