import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SurahTypeText extends StatelessWidget {
  final String surahType;
  final bool isDarkMode; // Accept dark mode status

  const SurahTypeText({
    super.key,
    required this.surahType,
    required this.isDarkMode, // Make it required
  });

  @override
  Widget build(BuildContext context) {
    // Determine color based on dark mode status
    final Color textColor = isDarkMode ? const Color(0xff4ea5f4) : const Color(0xff1d3f5e);

    final Color textColor2 = isDarkMode ? Colors.grey[400]! : Colors.grey[600]!;

    return Padding(
      padding: const EdgeInsets.only(top: 2.0), // Add a little space above
      child: Row(
        spacing: 5,
        children: [
          Text("•", style: TextStyle(
            fontSize: 25, // Slightly larger for better readability
              color: textColor2, // Apply dynamic color
              fontFamily: "SF-Pro", // Ensure this font is included in pubspec.yaml
              fontWeight: FontWeight.w600,
              height: 0
          ),),
          // surahType == "Madani" ? SvgPicture.asset("assets/images/madina.svg", width: 21, height: 21,) : SvgPicture.asset("assets/images/kaba.svg", width: 21, height: 21,),
          Text(
            surahType,
            style: TextStyle(
                fontSize: 11.5, // Slightly larger for better readability
                color: textColor, // Apply dynamic color
                fontFamily: "SF-Pro", // Ensure this font is included in pubspec.yaml
                fontWeight: FontWeight.w600,
                height: 0,
              letterSpacing: 0
            ),
          ),
        ],
      ),
    );
  }
}