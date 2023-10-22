part of 'place_bloc.dart';

@immutable
abstract class PlaceEvent {}

class SetPlaceEvent extends PlaceEvent {
  final Place place ;

  SetPlaceEvent({required this.place});
}

class GetPlaceEvent extends PlaceEvent {}

