import 'package:flutter/material.dart';
import 'pages/info.dart';
import 'pages/home.dart';
import 'pages/about.dart';

// Page Routes Configuration
final routesList = {
  '/' : (context) => new HomePage(),
  '/about' : (context) => new AboutPage(),
  '/info' : (context) => new InfoPageLoader(),
};

// Theme Data Configuration
const primary_col = const Color(0xFF02BB9F);
const primary_drk = const Color(0xFF167F67);
const accent_col = const Color(0xFF167F67);

final ThemeData appTheme = buildTheme();

buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: primary_col,
    primaryColorDark: primary_drk,
    accentColor: accent_col
  );
}