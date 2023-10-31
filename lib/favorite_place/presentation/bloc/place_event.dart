part of 'place_bloc.dart';

@immutable
abstract class PlaceEvent {}

class SetPlaceEvent extends PlaceEvent {
  final Place place ;

  SetPlaceEvent({required this.place});
}

class GetPlaceEvent extends PlaceEvent {}

class UpdatePlaceEvent extends PlaceEvent {
  final Place place ;

  UpdatePlaceEvent({required this.place});
}
class DeletePlaceEvent extends PlaceEvent {
  final Place place ;

  DeletePlaceEvent({required this.place});
}




