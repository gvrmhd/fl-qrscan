import 'package:flutter/material.dart';
import 'routes.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QRC Info',
      debugShowCheckedModeBanner: false,
      routes: routesList,
      initialRoute: '/',
    );
  }
}