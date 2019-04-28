import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _outputText = "Press the Scan Button !";
  String _kodeScan = 'Try Again !';

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() => _kodeScan = qrResult);
      Navigator.pushNamed(context, '/info', arguments: _kodeScan);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() => _outputText = "Camera Permission Denied");
        print(e);
      } else {
        setState(() => _outputText = "Unknown Error : $e");
        print(e);
      }
    } on FormatException catch (e) {
      _outputText = "Press the Scan Button !";
      print(e);
    } catch (e) {
      setState(() => _outputText = "Unknown Error : $e");
      print(e);
    }
  }

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
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
