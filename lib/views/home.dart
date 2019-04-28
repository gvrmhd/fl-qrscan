import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _outputText = "Press the Scan Button !";
  String _kodeScan = 'X1OPJS2FF';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("QR Scanner"),
        ),
        body: Center(
      child: Text(
        _outputText,
        style: Theme.of(context).textTheme.headline,
      ),
    ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.camera),
          label: Text("Scan"),
          onPressed: (){
            Navigator.pushNamed(context, '/info', arguments: _kodeScan);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }
}