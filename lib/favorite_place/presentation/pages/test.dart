import 'dart:async';
import 'dart:collection';

import 'package:favorite_places_app/favorite_place/presentation/pages/add_new_plase_page.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  var markers = HashSet<Marker>();
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  // var lat;
  // var long;
  late LatLng latLngg;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onTap: (LatLng latLng) {
          // Handle the tap event to get the latitude and longitude
          setState(() {
            latLngg = latLng;
            markers.clear(); // Clear previous markers
            markers.add(
              Marker(
                markerId: MarkerId('1'),
                position: latLng,
              ),
            );
          });
          print("Latitude: ${latLng.latitude}, Longitude: ${latLng.latitude}");
        },
        markers: markers,
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton.extended(
          onPressed: () async {

            Navigator.pop(context, latLngg) ;

          },
          label: const Text('Save '),
          icon: const Icon(Icons.save),
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

Future<Position> getCurrentPosition() async {
  await Geolocator.requestPermission();
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}