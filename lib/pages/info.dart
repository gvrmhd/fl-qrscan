import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Info Page"),
      ),
      body: Center(
        child: Text(args, style: Theme.of(context).textTheme.headline),
      ),
    );
  }
}
