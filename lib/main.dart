import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:quran_app/views/screens/favorite_verses.dart';
import 'package:quran_app/views/screens/home.dart';
import 'package:quran_app/views/screens/search_verses.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const QuranApp());
  // FlutterStatusbarcolor.setStatusBarColor(const Color(0xff1d3f5e), animate: true);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xff1d3f5e), // Change to your desired color
    statusBarBrightness: Brightness.light, // For iOS (light or dark)
    statusBarIconBrightness:
        Brightness.light, // For Android (light or dark icons)
  ));
}

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      // home: const SearchVerses(),
      home: const Home()
      // home: FavoriteVerses(isDarkMode: true.obs),
    );
  }
}
