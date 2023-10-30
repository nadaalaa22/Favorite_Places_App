import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:favorite_places_app/favorite_place/data/datasource/place_remote_datasource.dart';
import 'package:meta/meta.dart';

import '../../data/model/place.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final FavoritePlaceModel favoritePlaceModel ;
  PlaceBloc(this.favoritePlaceModel) : super(PlaceInitial()) {
    on<PlaceEvent>((event, emit) async {
      if (event is SetPlaceEvent) {
        emit(PlaceLoadingState());
        await favoritePlaceModel.addFavPlace(event.place);
        List<Place> places = await favoritePlaceModel.getFavPlaces() ;
        emit(PlaceLoadedState(places: places)) ;
      }

      else if (event is GetPlaceEvent) {
        emit(PlaceLoadingState());
        List<Place> places = await favoritePlaceModel.getFavPlaces() ;
        emit(PlaceLoadedState(places: places)) ;

      }

      else if (event is DeletePlaceEvent) {
        emit(PlaceLoadingState());
         await favoritePlaceModel.deleteFavPlace(event.place.id) ;
        List<Place> places = await favoritePlaceModel.getFavPlaces() ;
        emit(PlaceLoadedState(places: places)) ;

      }
      else if (event is UpdatePlaceEvent) {
        emit(PlaceLoadingState());
        await favoritePlaceModel.updateFavPlace(event.place) ;
        List<Place> places = await favoritePlaceModel.getFavPlaces() ;
        emit(PlaceLoadedState(places: places)) ;

      }
    });
  }
}
