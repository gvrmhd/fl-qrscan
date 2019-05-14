import 'package:flutter/material.dart';
import 'res/body.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: CustomBody(
        child: pageContent(),
        backNav: true,
        appBarTitle: 'About Page',
      ),
    );
  }

  showSnackbar() {
    final snack = SnackBar(
      content: Text('Flutter is Awesome'),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: '" I Know "',
        onPressed: () {},
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snack);
  }

  Widget pageContent() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: showSnackbar,
            child: FlutterLogo(size: 200),
          ),
          SizedBox(height: 15),
          Text(
            'This app is Created with Flutter',
            style:
                Theme.of(context).textTheme.title.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
