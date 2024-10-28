import 'package:flutter/material.dart';

class SurahTypeText extends StatelessWidget {
  final String surahType;
  const SurahTypeText({super.key, required this.surahType});

  @override
  Widget build(BuildContext context) {
    return Text(
      surahType,
      style: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.w900,
          fontFamily: "SF-Pro"),
    );
  }
}
