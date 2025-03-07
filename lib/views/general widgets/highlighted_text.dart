import 'package:flutter/material.dart';

class HighlightedText {
  List<TextSpan> highlightSearchedText(String fullText, String keyword, bool isDarkMode) {
    if (keyword.isEmpty) {
      return [TextSpan(text: fullText)];
    }

    List<TextSpan> spans = [];
    String lowerFullText = fullText.toLowerCase();
    String lowerKeyword = keyword.toLowerCase();
    int start = 0;

    // Find occurrences of the keyword and split the text
    while (true) {
      final startIndex = lowerFullText.indexOf(lowerKeyword, start);
      if (startIndex == -1) {
        // Add the remaining part of the text
        spans.add(TextSpan(
          text: fullText.substring(start),
          style: TextStyle(
            color: isDarkMode
                ? Colors.white.withOpacity(.35)
                : const Color(0xff1d3f5e).withOpacity(.55),
          ),
        ));
        break;
      }

      // Add the text before the keyword
      if (startIndex > start) {
        spans.add(TextSpan(
          text: fullText.substring(start, startIndex),
          style: TextStyle(
            color: isDarkMode
                ? Colors.white.withOpacity(.35)
                : const Color(0xff1d3f5e).withOpacity(.55),
          ),
        ));
      }

      // Add the keyword in red
      spans.add(TextSpan(
        text: fullText.substring(startIndex, startIndex + keyword.length),
        style: const TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.w900
        ),
      ));

      start = startIndex + keyword.length;
    }

    return spans;
  }

}