import 'package:meta/meta.dart';

@immutable
class Tour {
  final String assetImage;
  final String name;

  Tour({@required this.assetImage, @required this.name});
}

List<Tour> getTours() {
  return [
    Tour(name: 'England', assetImage: 'assets/images/london.jpg'),
    Tour(name: 'France', assetImage: 'assets/images/paris.jpg'),
    Tour(name: 'Ukraine', assetImage: 'assets/images/kyiv.jpg'),
    Tour(name: 'Portugal', assetImage: 'assets/images/lissabon.jpg'),
    Tour(name: 'Australia', assetImage: 'assets/images/sydney.jpg'),
    Tour(name: 'USA', assetImage: 'assets/images/newyork.png'),
  ];
}
