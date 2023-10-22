import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/place.dart';

abstract class FavoritePlaceModel{
  ///add place data to [sharedPreference]
  ///
  /// throw an error
  Future<void> setFavPlace( Place place );

  ///get all fav places from  [sharedPreference]
  ///
  /// throw an error
  Future<List<Place>> getFavPlaces();

}
const  String placesKey = 'place' ;
class FavoritePlaceImp implements FavoritePlaceModel {

  @override
  Future<List<Place>> getFavPlaces() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final placesJson = prefs.getStringList(placesKey) ?? [];
    List<Place> placesList = [];
    for (int i = 0; i < placesJson.length; i++) {
      final categoryJson = placesJson[i];
      final Map placeMap = jsonDecode(categoryJson);
      Place places = Place.fromMap(placeMap);
      placesList.add(places);
    }

    return placesList;
  }

  @override
  Future<void> setFavPlace(Place place) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String placeJson = jsonEncode(place.toMap());
    List<String> placesJson = prefs.getStringList(placesKey) ?? [];
    placesJson.add(placeJson);
    await prefs.setStringList(placesKey, placesJson);
  }
}

