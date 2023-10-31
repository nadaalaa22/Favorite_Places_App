import 'dart:convert';
import 'package:favorite_places_app/favorite_place/data/model/google_map_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';


abstract class GoogleMapRemoteDS {
  ///
  /// throw an error
  Future<GoogleMapModel> getMapData(LatLng originLatLng ,LatLng destinationLatLng);

}
class GoogleMapModelImp implements GoogleMapRemoteDS{

  @override
  Future<GoogleMapModel> getMapData(LatLng originLatLng ,LatLng destinationLatLng) async {
    final origin = originLatLng;
    final destination = destinationLatLng;
    const apiKey = 'AIzaSyDi-bSYjtEknQ7O7V05Hg7oWRLWPnU0rXU';
    final apiUrl =
        'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$origin&destinations=$destination&key=$apiKey';
    var url = Uri.parse(apiUrl) ;
    var response = await get(url) ;
    if(response.statusCode>199 && response.statusCode<300)
    {
      Map jsonDecodeMap = jsonDecode(response.body);
      if(jsonDecodeMap['rows'][0]['elements'][0]['status']=='OK')
        {
          print('from get');
          print(response.body);
          return  GoogleMapModel.fromMap(jsonDecodeMap);
        }
      else
      {
        print('not found');
        return  GoogleMapModel.fromMap(jsonDecodeMap);
      }


    }
    else
    {
      print('error with status : ${response.statusCode}') ;
      throw Exception('api failed');
    }
  }



}