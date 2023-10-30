import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key, required this.currentLocation});
  final LatLng currentLocation ;

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  var markers = HashSet<Marker>();
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  late LatLng latLngg;
  Map<PolylineId, Polyline> polylines = {}; // Add this line to manage polylines

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.currentLocation.latitude, widget.currentLocation.longitude),
          zoom: 10,
        ),
        onTap: (LatLng latLng) async {
          setState(() {
            markers.clear(); // Clear previous markers
            markers.add(
              Marker(
                markerId: MarkerId('1'),
                position: latLng,
              ),
            );
            markers.add(
              Marker(
                icon: BitmapDescriptor.defaultMarkerWithHue(50),
                markerId: MarkerId('2'),
                position: widget.currentLocation, // Adjust the coordinates for the second marker as needed
              ),
            );
            latLngg = latLng; // Assign the tapped LatLng to latLngg
          });

          // Rest of your polyline code
          PolylinePoints polylinePoints = PolylinePoints();

          LatLng startPoint = LatLng(widget.currentLocation.latitude, widget.currentLocation.longitude);
          LatLng endPoint = LatLng(latLngg.latitude, latLngg.longitude);

          PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
            'AIzaSyDi-bSYjtEknQ7O7V05Hg7oWRLWPnU0rXU',
            PointLatLng(startPoint.latitude, startPoint.longitude),
            PointLatLng(endPoint.latitude, endPoint.longitude),
          );

          if (result.status == 'OK') {
            List<PointLatLng> polylineCoordinates = result.points;

            // Create a Polyline and add it to the map
            Polyline polyline = Polyline(
              polylineId: PolylineId('polyline_id'),
              color: Colors.blue, // Color of the polyline
              points: polylineCoordinates
                  .map((point) => LatLng(point.latitude, point.longitude))
                  .toList(),
            );

            // Update the state to include the polyline
            setState(() {
              polylines[PolylineId('polyline_id')] = polyline;
            });
          }
        },
        markers: markers,
        polylines: Set<Polyline>.from(polylines.values),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton.extended(
          onPressed: () async {
            Navigator.pop(context, latLngg);
          },
          label: const Text('Save'),
          icon: const Icon(Icons.save),
        ),
      ),
    );
  }
}

