import 'dart:io';
import 'package:favorite_places_app/favorite_place/data/model/place.dart';
import 'package:flutter/material.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';


class FavPlacesInfoPage extends StatelessWidget {
  final Place placeModel;
  const FavPlacesInfoPage({super.key, required this.placeModel});

  @override
  Widget build(BuildContext context) {
    var _controller = StaticMapController(
      googleApiKey: "AIzaSyDi-bSYjtEknQ7O7V05Hg7oWRLWPnU0rXU",
      width: 400,
      height: 400,
      zoom: 10,
      center: Location(placeModel.latitude, placeModel.longitude),
    );
    ImageProvider image = _controller.image;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(placeModel.name, style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(File(placeModel.imageUrl)),
                fit: BoxFit.cover, // Adjust as needed
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundImage: image,
                  radius: 50,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '${placeModel.address}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}