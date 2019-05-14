import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'res/body.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _kodeScan;

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

  Widget scanCardButton() {
    final vHeight = MediaQuery.of(context).size.height;
    final vWidth = MediaQuery.of(context).size.width;
    final assetImg = AssetImage('assets/images/scanner.png');
    final scanImage = Image(
      image: assetImg,
      height: 100,
      color: Colors.white,
    );
    final hintText = Text(
      'SCAN',
      style: Theme.of(context).textTheme.headline.copyWith(
            color: Colors.white,
          ),
    );

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Color(0xFF44A08D),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: new Offset(3, 5),
              blurRadius: 8,
            ),
          ]),
      alignment: Alignment.center,
      width: vWidth * 0.5,
      height: vHeight * 0.3 - 5,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25.0),
          onTap: () => _scanQR(),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 5),
                scanImage,
                SizedBox(height: 30),
                hintText,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: CustomBody(
        appBarTitle: 'QR Scanner',
        child: Center(child: scanCardButton()),
        appBarAction: IconButton(
          icon: Icon(
            Icons.info,
          ),
          onPressed: () => Navigator.pushNamed(context, '/about'),
        ),
      ),
    );
  }
}
