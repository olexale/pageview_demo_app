import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pageview_demo_app/repository.dart';

class TravelPageBasic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(children: <Widget>[
        PageView(
            children: getTours()
                .map((tour) => Center(
                      child: Text(tour.name, textScaleFactor: 3),
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
              Text('travel guide')
            ],
          )),
          RaisedButton(child: Text('open tour'), onPressed: () {})
        ]),
      ]),
    );
  }
}
