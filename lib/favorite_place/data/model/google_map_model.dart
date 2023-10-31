class GoogleMapModel {
  final String distance ,duration ;

  GoogleMapModel({required this.distance, required this.duration});

  factory GoogleMapModel.fromMap(Map map) => GoogleMapModel(
    distance: map['rows'][0]['elements'][0]['distance']['text'],
    duration : map['rows'][0]['elements'][0]['duration']['text'],

  );



}