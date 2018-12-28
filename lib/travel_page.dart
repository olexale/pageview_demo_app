import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pageview_demo_app/repository.dart';

const _kBlurMultiplier = 7;

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  PageController _pageController;
  double _backgroundBlur = 0;
  String _currentImage;
  String _nextImage;
  double _nextImageOpacity;
  final _images = getTours().map((tour) => tour.assetImage).toList();

  void initState() {
    super.initState();
    _pageController = PageController();
    _currentImage = _images.first;
    _nextImage = _images[1];
    _nextImageOpacity = 0;
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
        Positioned.fill(
            child: Opacity(
                opacity: _nextImageOpacity,
                child: Image.asset(_nextImage, fit: BoxFit.cover))),
        NotificationListener<ScrollNotification>(
            onNotification: _onPageScroll,
            child: PageView(
                controller: _pageController,
                children: getTours()
                    .map((tour) => Center(
                          child: Text(
                            tour.name,
                            textScaleFactor: 3,
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                    .toList())),
        Positioned.fill(
          child: new BackdropFilter(
            filter: new ImageFilter.blur(
                sigmaX: _backgroundBlur, sigmaY: _backgroundBlur),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IgnorePointer(
                    child: new Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: SizedBox(
                                  width: double.infinity,
                                  height: 100,
                                  child: FlutterLogo()),
                            ),
                            Text(
                              'travel guide',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                        decoration:
                            new BoxDecoration(color: Colors.transparent)),
                  ),
                  RaisedButton(child: Text('open tour'), onPressed: () {})
                ]),
          ),
        ),
      ]),
    );
  }

  double _scrollStartPosition;
  bool _onPageScroll(ScrollNotification notification) {
    if (notification is UserScrollNotification) return true;

    if (notification is ScrollEndNotification) {
      setState(() {
        _nextImageOpacity = 0;
        _currentImage = _images[_pageController.page.round()];
      });
      return true;
    }

    if (notification is ScrollStartNotification) {
      _scrollStartPosition = notification.metrics.pixels;
    }

    final nextImageIndex = _getNextImageIndex(
        notification.metrics.pixels, notification.metrics.viewportDimension);

    final newBlur = _getBlurSigma(notification) * _kBlurMultiplier;

    final newNextImageOpacity = _getNextImageOpacity(notification);

    setState(() {
      _nextImage = _images[nextImageIndex];
      _nextImageOpacity = newNextImageOpacity;
      _backgroundBlur = newBlur;
    });

    return true;
  }

  double _getNextImageOpacity(ScrollNotification notification) {
    var newNextImageOpacity =
        ((notification.metrics.pixels - _scrollStartPosition).abs()) /
            notification.metrics.viewportDimension;

    if (newNextImageOpacity < 0) newNextImageOpacity = 0;
    if (newNextImageOpacity > 1) newNextImageOpacity = 1;
    return newNextImageOpacity;
  }

  double _getBlurSigma(ScrollNotification notification) {
    final rest =
        notification.metrics.pixels % notification.metrics.viewportDimension;
    final halfScreen = notification.metrics.viewportDimension / 2;
    final offset = (halfScreen - rest).abs();
    return 1 - offset / halfScreen;
  }

  int _getNextImageIndex(double currentOffset, double viewportWidth) {
    final isScrollingLeft = (_scrollStartPosition - currentOffset) > 0;
    final page = currentOffset ~/ viewportWidth + (isScrollingLeft ? 1 : 0);

    if (isScrollingLeft && page == 0) return 0;
    if (!isScrollingLeft && page == (_images.length - 1)) return page;

    if (isScrollingLeft) return page - 1;
    return page + 1;
  }
}
