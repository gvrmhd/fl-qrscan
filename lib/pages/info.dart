import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String kodeQR = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Info Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: Firestore.instance
              .collection('information')
              .document(kodeQR.trim())
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return ErrorMessage();
              } else {
                return DataListView(snapshot: snapshot);
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class ErrorMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          errorText('QR Info Not Found !!'),
          errorText('Please Try Again')
        ],
      ),
    );
  }

  Widget errorText(String msg) {
    return Text(
      msg, style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class DataListView extends StatelessWidget {
  final AsyncSnapshot snapshot;

  const DataListView({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        displayImage(snapshot.data['imageref']),
        SizedBox(height: 10),
        displayTitle(context, snapshot.data['title']),
        SizedBox(height: 5),
        displayInfo(context, snapshot.data['info']),
      ],
    );
  }

  Widget displayTitle(context, String title) {
    return Container(
      child: Text(title, style: Theme.of(context).textTheme.headline),
    );
  }

  Widget displayImage(String imageRef) {
    return Container(
      height: 200,
      child: Stack(
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(),
          ),
          Center(
            child: FadeInImage.memoryNetwork(
              image: imageRef,
              placeholder: kTransparentImage,
            ),
          )
        ],
      ),
    );
  }

  Widget displayInfo(context, String info) {
    return Container(
      child: Text(
        info,
        style: Theme.of(context).textTheme.body1,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
