import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class InfoPageLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String kodeQR = ModalRoute.of(context).settings.arguments;
    final vHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder(
        future: Firestore.instance
            .collection('information')
            .document(kodeQR.trim())
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot templist = snapshot.data;
            Map<dynamic, dynamic> list = templist.data;

            return list != null
                ? InfoPage(data: list)
                : customErrorPage(context, vHeight);
          }
          if (snapshot.hasError) {
            return customErrorPage(context, vHeight);
          }
          return mainBody(
            vHeight,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Widget customErrorPage(context, vHeight) {
    return Stack(
      children: <Widget>[
        mainBody(
          vHeight,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.white,
                  size: 80,
                ),
                SizedBox(height: 20),
                Text(
                  'Oops data tidak ditemukan ...\nSilahkan coba Lagi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: 33, fontFamily: 'London'),
                ),
              ],
            ),
          ),
        ),
        customAppBar(context, title: 'ERROR'),
      ],
    );
  }

  Widget mainBody(vHeight, {Widget child}) {
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

  Widget customAppBar(context, {String title: ''}) {
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
        title: Text(
          title,
          style: TextStyle(fontFamily: 'London', fontSize: 30),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}

class InfoPage extends StatefulWidget {
  final Map<dynamic, dynamic> data;
  const InfoPage({Key key, this.data}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int _current = 0;
  double vHeight;
  double vWidth;
  String kodeQR;

  @override
  Widget build(BuildContext context) {
    vHeight = MediaQuery.of(context).size.height;
    vWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: customMainPage(),
    );
  }

  Widget customMainPage() {
    return Stack(
      children: <Widget>[
        mainBody(
          vHeight,
          child: pageContent(),
        ),
        customAppBar(context, title: widget.data['title']),
      ],
    );
  }

  Widget pageContent() {
    return ListView(
      children: <Widget>[
        carouselWithIndicator(),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.all(20),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: locationInfo(),
              ),
              SizedBox(width: 10),
              dateInfo(),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: widget.data['info']
                .map<Widget>((item) => Container(
                      child: Text(
                        '\t\t\t\t\t $item \n',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 17, color: Colors.white70),
                      ),
                    ))
                .toList(),
          ),
          alignment: Alignment.topLeft,
        )
      ],
    );
  }

  _zoomImage(ref) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Hero(
                  tag: ref,
                  child: Image.network(ref),
                ),
              ),
            )));
  }

  Widget carouselWithIndicator() {
    List<Widget> imageList;
    imageList = widget.data['imageref']
        .map<Widget>(
          (item) => Container(
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.circular(25)),
                child: InkWell(
                  onTap: () => _zoomImage(item),
                  child: Hero(
                    tag: item,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: FadeInImage.memoryNetwork(
                        image: item,
                        fit: BoxFit.cover,
                        width: 1000,
                        placeholder: kTransparentImage,
                      ),
                    ),
                  ),
                ),
              ),
        )
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          items: imageList,
          autoPlay: false,
          enlargeCenterPage: true,
          onPageChanged: (index) {
            setState(() {
              _current = index;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.data['imageref'].length,
            (index) => Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                ),
          ),
        ),
      ],
    );
  }

  _launchURL() async {
    final url = widget.data['gmap'];
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch URL');
    }
  }

  Widget locationInfo() {
    return Container(
        height: vHeight * 0.15,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _launchURL(),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                    radius: 25,
                    child: Image.asset(
                      'assets/icons/gmap.png',
                      height: 32,
                      color: Colors.white,
                    )),
                Expanded(
                  child: Center(
                    child: Text(
                      "${widget.data['place']}",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF093637),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CaviarDreams'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget dateInfo() {
    return Container(
      height: vHeight * 0.15,
      width: vWidth * 0.3,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white30, borderRadius: BorderRadius.circular(5.0)),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 25,
            child: Icon(
              Icons.date_range,
              size: 33,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "${widget.data['year']}",
                style: TextStyle(
                    fontFamily: 'CaviarDreams',
                    fontSize: 25,
                    color: Color(0xFF093637),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mainBody(vHeight, {Widget child}) {
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

  Widget customAppBar(context, {String title: ''}) {
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
        title: Text(
          title,
          style: TextStyle(fontFamily: 'London', fontSize: 30),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
