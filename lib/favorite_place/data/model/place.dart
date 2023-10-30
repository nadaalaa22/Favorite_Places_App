import 'package:cloud_firestore/cloud_firestore.dart';

class Place {
  final String id, userId, name, description, imageUrl, address;

  final double latitude, longitude;

  Place(
      {required this.id,
      required this.userId,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.address,
      required this.latitude,
      required this.longitude});

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
      };

  factory Place.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
      Place(
          id: doc.id,
          userId: doc.data()['userId'],
          name: doc.data()['name'],
          description: doc.data()['description'],
          imageUrl: doc.data()['imageUrl'],
          address: doc.data()['address'],
          latitude: doc.data()['latitude'],
          longitude: doc.data()['longitude']);
}
