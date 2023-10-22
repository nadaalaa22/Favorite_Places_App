import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:favorite_places_app/favorite_place/data/datasource/place_local_datasource.dart';
import 'package:meta/meta.dart';

import '../../data/model/place.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  PlaceBloc() : super(PlaceInitial()) {
    on<PlaceEvent>((event, emit) async {
      if (event is SetPlaceEvent) {
        emit(PlaceLoadingState());
        await FavoritePlaceImp().setFavPlace(event.place);
        List<Place> places = await FavoritePlaceImp().getFavPlaces() ;
        emit(PlaceLoadedState(places: places)) ;
      }

      else if (event is GetPlaceEvent) {
        emit(PlaceLoadingState());
        List<Place> places = await FavoritePlaceImp().getFavPlaces() ;
        emit(PlaceLoadedState(places: places)) ;

      }
    });
  }
}
