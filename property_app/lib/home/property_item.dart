import 'dart:math';

class PropertyItem{
  int id;
  bool available;
  String type;
  double cost;
  String description;
  List<String> categories;
  List<String> imagePath;
  Point<double> position;
  int beds;
  int baths;
  int parkPlaces;
  bool bookmarked;

  PropertyItem({
    required this.type,
    required this.cost,
    required this.position,
    required this.beds,
    this.id = -1,
    this.available = true,
    this.description = "",
    this.categories = const [],
    this.imagePath = const [],
    this.baths = 1,
    this.parkPlaces = 0,
    this.bookmarked = false,
    }
  );
}



