import 'package:flutter/material.dart';
import './config/routes.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routesList,
      initialRoute: '/',
    );
  }
}