import 'package:geocoding/geocoding.dart';

class Place {
  final String title, image;

  final List<dynamic> placeMarks;

  Place({
    required this.title,
    required this.image,
    required this.placeMarks,
  });

  // Serialize a Place instance to a Map
  Map toMap() => {
        'title': title,
        'image': image,
        'placeMarks': placeMarks,
      };

  factory Place.fromMap(Map map) => Place(
      title: map['title'], image: map['image'], placeMarks: map['placeMarks']);
}
