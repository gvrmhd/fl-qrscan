import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            onTap: _scanQR,
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
        ));
  }

  Widget mainBody() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [const Color(0xFF093637), const Color(0xFF44A08D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Center(child: scanCardButton()),
    );
  }

  Widget customAppBar() {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: AppBar(
        title: Text('QR Scanner',
            style: TextStyle(fontFamily: 'London', fontSize: 30)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.info,
            ),
            onPressed: () =>
                Navigator.pushNamed(context, '/about', arguments: _kodeScan),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          mainBody(),
          customAppBar(),
        ],
      ),
    );
  }
}
