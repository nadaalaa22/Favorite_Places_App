import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/place.dart';
import '../bloc/place_bloc.dart';
import '../pages/fav_place_info_page.dart';
class PlaceItem extends StatelessWidget {
  const PlaceItem({Key? key, required this.place}) : super(key: key);
  final  Place place ;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key:Key(place.id),
      onDismissed: (direction) {
        context
            .read<PlaceBloc>()
            .add(DeletePlaceEvent(place: place));
      },
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=> FavPlacesInfoPage(placeModel: place,) ) );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35.0,
                  backgroundImage: FileImage(
                    File(place.imageUrl)
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                       place.address,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
