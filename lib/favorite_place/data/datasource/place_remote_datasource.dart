import 'package:favorite_places_app/favorite_place/data/datasource/remote_db_helper.dart';

import '../model/place.dart';

abstract class FavoritePlaceModel {
  ///add place data to [sharedPreference]
  ///
  /// throw an error
  Future<void> addFavPlace(Place place);

  ///get all fav places from  [sharedPreference]
  ///
  /// throw an error
  Future<List<Place>> getFavPlaces();

  ///

  Future<void> updateFavPlace(Place place);

  ///
  Future<void> deleteFavPlace(String placeId);
}

const collectionName = 'Places';

class FavoritePlaceImp implements FavoritePlaceModel {
  final RemoteDBHelper dbHelper;

  FavoritePlaceImp(this.dbHelper);

  @override
  Future<void> addFavPlace(Place place) =>
      dbHelper.add(collectionName, place.toMap());

  @override
  Future<void> deleteFavPlace(String placeId) =>
      dbHelper.delete(collectionName, placeId);

  @override
  Future<List<Place>> getFavPlaces() async =>
      List<Place>.from(await dbHelper.get(collectionName, Place.fromDoc));

  @override
  Future<void> updateFavPlace(Place place) =>
      dbHelper.update(collectionName, place.id, place.toMap());
}
