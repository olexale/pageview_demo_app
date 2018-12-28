import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pageview_demo_app/repository.dart';

class TravelPageWithImages extends StatefulWidget {
  @override
  _TravelPageWithImagesState createState() => _TravelPageWithImagesState();
}

class _TravelPageWithImagesState extends State<TravelPageWithImages> {
  PageController _pageController;
  String _currentImage;
  final _images = getTours().map((tour) => tour.assetImage).toList();

  void initState() {
    super.initState();
    _pageController = PageController();
    _currentImage = _images.first;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(children: <Widget>[
        Positioned.fill(child: Image.asset(_currentImage, fit: BoxFit.cover)),
        PageView(
            onPageChanged: _onPageChanged,
            children: getTours()
                .map((tour) => Center(
                      child: Text(tour.name,
                          textScaleFactor: 3,
                          style: TextStyle(color: Colors.white)),
                    ))
                .toList()),
        Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          new Container(
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: SizedBox(
                    width: double.infinity, height: 100, child: FlutterLogo()),
              ),
              Text('travel guide',
                  style: TextStyle(color: Colors.white, fontSize: 20))
            ],
          )),
          RaisedButton(child: Text('open tour'), onPressed: () {})
        ]),
      ]),
    );
  }

  void _onPageChanged(int page) =>
      setState(() => _currentImage = _images[page]);
}
