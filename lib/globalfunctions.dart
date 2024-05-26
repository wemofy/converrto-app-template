import 'package:flutter/material.dart';

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

bool isNetworkUrl(String url) {
  return url.startsWith('http://') || url.startsWith('https://');
}

FontWeight getFontWeight(int weight) {
  switch (weight) {
    case 1:
      return FontWeight.w100;
    case 2:
      return FontWeight.w200;
    case 3:
      return FontWeight.w300;
    case 4:
      return FontWeight.w400;
    case 5:
      return FontWeight.w500;
    case 6:
      return FontWeight.w600;
    case 7:
      return FontWeight.w700;
    case 8:
      return FontWeight.w800;
    case 9:
      return FontWeight.w900;
    default:
      throw ArgumentError('Weight must be an integer between 1 and 9');
  }
}

String convertToAssetPath(String filename) {
  if (!filename.contains('/')) {
    return 'assets/nav_icons/$filename';
  } else {
    return filename; // Assuming filename is already a complete path
  }
}