import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:quran_app/views/screens/favorite_verses.dart';
import 'package:quran_app/views/screens/home.dart';
import 'package:quran_app/views/screens/search_verses.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterStatusbarcolor.setStatusBarColor(const Color(0xff1d3f5e), animate: true);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xff1d3f5e), // Change to your desired color
    statusBarBrightness: Brightness.light, // For iOS (light or dark)
    statusBarIconBrightness:
    Brightness.light, // For Android (light or dark icons)
  ));
  Future.delayed(const Duration(milliseconds: 200), () => runApp(const QuranApp()));
}

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        builder: (context, child) {
          final mediaQuery = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQuery.copyWith(textScaler: const TextScaler.linear(1.0),
              devicePixelRatio: 1.0, ),
            child: child!,
          );
        },
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      // home: const SearchVerses(),
      home: const Home()
      // home: FavoriteVerses(isDarkMode: true.obs),
    );
  }
}
