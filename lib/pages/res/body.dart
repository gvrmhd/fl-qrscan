import 'package:flutter/material.dart';

class CustomBody extends StatelessWidget {
  final Widget child;
  final String appBarTitle;
  final bool backNav;
  final Widget appBarAction;
  final bool noAppBar;

  const CustomBody(
      {Key key,
      this.appBarTitle: '',
      this.backNav: false,
      this.appBarAction,
      this.child,
      this.noAppBar: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        customBackground(context),
        noAppBar ? Container() : customAppBar(context)
      ],
    );
  }

  Widget customBackground(context) {
    final vHeight = MediaQuery.of(context).size.height;

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [const Color(0xFF093637), const Color(0xFF44A08D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Container(
        margin: EdgeInsets.only(top: vHeight * 0.1),
        child: child,
      ),
    );
  }

  Widget customAppBar(context) {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: AppBar(
        leading: backNav
            ? IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  size: 35,
                ),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: Text(
          appBarTitle,
          style: TextStyle(fontFamily: 'London', fontSize: 30),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: appBarAction == null ? null : <Widget>[appBarAction],
      ),
    );
  }
}
