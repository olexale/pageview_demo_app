import 'package:flutter/material.dart';
import 'package:pageview_demo_app/travel_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Guide Demo',
      home: TravelPage(),
    );
  }
}
