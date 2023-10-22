part of 'place_bloc.dart';

@immutable
abstract class PlaceState {}

class PlaceInitial extends PlaceState {}
class PlaceLoadingState extends PlaceState {}
class PlaceLoadedState extends PlaceState {
  final List<Place>  places ;

  PlaceLoadedState({required this.places});
}
