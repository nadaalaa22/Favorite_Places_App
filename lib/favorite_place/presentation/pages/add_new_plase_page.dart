import 'dart:io';
import 'package:favorite_places_app/favorite_place/presentation/pages/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/model/place.dart';
import '../bloc/place_bloc.dart';

class AddNewPlace extends StatefulWidget {
  AddNewPlace({Key? key,})
      : super(key: key);

  @override
  State<AddNewPlace> createState() => _AddNewPlaceState();
}
class _AddNewPlaceState extends State<AddNewPlace> {
  var title = TextEditingController();
  String  serviceEnabled =  '' ;
  bool isImage = false ;
  File? imageFile ;
  GlobalKey<FormState> keyTitle = GlobalKey();
  late List<Placemark> placemarks ;


  Future<Position?> determinePosition()
  async {
    await Geolocator.requestPermission();
    final  permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      return  Geolocator.getCurrentPosition() ;
    }
    return null ;
  }
  Future<File?> getImage(ImageSource source) async {
    XFile ? xFile = await ImagePicker().pickImage(source: source) ;
    if (xFile != null){
      return File(xFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
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
                          color:
                              Colors.white), // Set focused border color to white
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
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
                  child: isImage?
                      Image.file(File(imageFile!.path))
                   : TextButton(
                      onPressed: () async {
                       await getImage(ImageSource.camera).then((value) =>setState(() {
                          imageFile = value ;
                        })
                        ) ;
                        setState(() {
                          isImage = true ;
                        });
                      }, child: Text("Take a photo",style: TextStyle(fontSize: 24),)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image(
                    image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ1DuYcvCkjQeDtqHzsS-rQpmLC2deO0BI2g&usqp=CAU')),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      Position? position =  await determinePosition() ;
                      setState(() {
                        serviceEnabled=position.toString();
                      });
                       placemarks = await placemarkFromCoordinates(position!.latitude,position!.longitude);
                      print(placemarks);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.pinkAccent, // Text color
                    ),
                    child: Row(
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
                    LatLng latling =  await Navigator.push(context, MaterialPageRoute(builder: (_)=> MapSample()));
                    placemarks = await placemarkFromCoordinates(latling.latitude,latling.longitude);
                    print(placemarks);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.pinkAccent, // Text color
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.map),
                        SizedBox(width: 8),
                        Text("Select on Map"),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                 if(keyTitle.currentState!.validate())
                   {
                     Place place =Place(
                       title: title.text,
                       image: imageFile!.path,
                       placeMarks: placemarks ,
                     );
                     context.read<PlaceBloc>().add(SetPlaceEvent(place: place)) ;
                   }
                },
                child: Text(
                  '+ Add Place',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
