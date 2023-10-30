import 'dart:io';
import 'package:favorite_places_app/favorite_place/presentation/pages/map_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart' as gmaps;
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/model/place.dart';
import '../bloc/place_bloc.dart';

class AddNewPlace extends StatefulWidget {
  const AddNewPlace({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNewPlace> createState() => _AddNewPlaceState();
}

class _AddNewPlaceState extends State<AddNewPlace> {

  var title = TextEditingController();
  bool isImage = false;
  File? imageFile;
  GlobalKey<FormState> keyTitle = GlobalKey();
  late Placemark place;
   LatLng? latLng ;

  Future<Position?> determinePosition() async {
    await Geolocator.requestPermission();
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return Geolocator.getCurrentPosition();
    }
    return null;
  }

  Future<File?> getImage(ImageSource source) async {
    XFile? xFile = await ImagePicker().pickImage(source: source);
    if (xFile != null) {
      return File(xFile.path);
    }
  }
  late ImageProvider image ;

  @override
  Widget build(BuildContext context) {
    if (latLng != null) {
      var controller = gmaps.StaticMapController(
        googleApiKey: "AIzaSyDi-bSYjtEknQ7O7V05Hg7oWRLWPnU0rXU",
        width: 400,
        height: 400,
        zoom: 10,
        center: gmaps.Location(latLng!.latitude, latLng!.longitude),
      );
      image = controller.image;
    }
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Add New Place',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: keyTitle,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: title,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.white),
                    // Set the hint text color to white
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white), // Set border color to white
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .white), // Set focused border color to white
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return 'field can not be null';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: isImage
                      ? Image.file(File(imageFile!.path))
                      : TextButton(
                          onPressed: () async {
                            await getImage(ImageSource.camera)
                                .then((value) => setState(() {
                                      imageFile = value;
                                    }));
                            setState(() {
                              isImage = true;
                            });
                          },
                          child: const Text(
                            "Take a photo",
                            style: TextStyle(fontSize: 24),
                          )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child:  SizedBox(
                  width: 400,
                    height: 200,
                    child: Image(image: latLng!=null? image :const NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ1DuYcvCkjQeDtqHzsS-rQpmLC2deO0BI2g&usqp=CAU')
                 , fit: BoxFit.cover)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      Position? position = await determinePosition();
                      latLng = LatLng(position!.latitude, position!.longitude);
                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                              position!.latitude, position!.longitude);

                      setState(() {
                        place = placemarks.first;
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.pinkAccent, // Text color
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.location_on),
                        // Icon for "Get Current Location"
                        SizedBox(width: 8),
                        // Add spacing between the icon and text
                        Text("Get Current Location"),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      Position? position = await determinePosition();
                     final latLngOfCurrentLocation = LatLng(position!.latitude, position!.longitude);
                     latLng  = await Navigator.push(context,
                          MaterialPageRoute(builder: (_) =>  MapSample(currentLocation: latLngOfCurrentLocation,)));
                     final places =
                     await placemarkFromCoordinates(latLng!.latitude, latLng!.longitude);
                     if (places.isNotEmpty) {
                       setState(() {
                         place = places.first;
                       });

                     }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.pinkAccent, // Text color
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.map),
                        SizedBox(width: 8),
                        Text("Select on Map"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  if (keyTitle.currentState!.validate()) {
                    Place placeData = Place(
                        id: '',
                        userId: '',
                        name: title.text,
                        description: '',
                        imageUrl: imageFile!.path,
                        address: '${place.country} ${place.street}',
                        latitude: latLng!.latitude,
                        longitude: latLng!.longitude) ;
                    context.read<PlaceBloc>().add(SetPlaceEvent(place: placeData)) ;
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.grey[700],
                ),
                child: const Text(
                  '+ Add Place',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
