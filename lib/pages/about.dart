import 'package:flutter/material.dart';

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
      body: Stack(
        children: <Widget>[
          mainBody(),
          customAppBar(),
        ],
      ),
    );
  }

  showSnackbar() {
    final snack = SnackBar(
      content: Text('Flutter is Awesome'),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: '" I Know "',
        onPressed: (){},
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

  Widget mainBody() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [const Color(0xFF093637), const Color(0xFF44A08D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Center(child: pageContent()),
    );
  }

  Widget customAppBar() {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            size: 35,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('About Us'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
