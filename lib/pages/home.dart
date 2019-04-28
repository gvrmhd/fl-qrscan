import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _kodeScan = 'Try Again !';

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() => _kodeScan = qrResult);
      Navigator.pushNamed(context, '/info', arguments: _kodeScan);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        showSnackbar('Camera Access Denied !');
        print(e);
      } else {
        showSnackbar('Error Occured');
        print(e);
      }
    } on FormatException catch (e) {
      print(e);
    } catch (e) {
      showSnackbar('Error Occured');
      print(e);
    }
  }

  showSnackbar(String msg) {
    final snack = SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 2),
    );
    _scaffoldKey.currentState.showSnackBar(snack);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("QR Scanner"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[DisplayImage(), SizedBox(height: 30), DisplayText(),SizedBox(height: 50)],
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

class DisplayText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Press the Scan Button !',
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }
}

class DisplayImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImg = AssetImage('assets/images/qrcode.png');
    Image image = Image(image: assetImg);

    return Center(
      child: image,
    );
  }
}
