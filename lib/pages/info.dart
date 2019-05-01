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
                return ListView(
                  children: <Widget>[
                    displayImage(snapshot.data['imageref']),
                    SizedBox(height: 10),
                    displayTitle(context, snapshot.data['title']),
                    SizedBox(height: 5),
                    displayInfo(context, snapshot.data['info']),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Widget displayTitle(context, String title) {
    return Container(
      child: Text(title, style: Theme.of(context).textTheme.headline),
    );
  }

  Widget displayImage(String imageRef) {
    return Container(
        height: 300,
        child: Stack(
          children: <Widget>[
            Center(child: CircularProgressIndicator()),
            Center(
              child: FadeInImage.memoryNetwork(
                image: imageRef,
                placeholder: kTransparentImage,
              ),
            )
          ],
        ));
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
