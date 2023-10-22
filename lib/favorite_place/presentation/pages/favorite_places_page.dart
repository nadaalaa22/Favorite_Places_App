import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/place_bloc.dart';
import '../widgets/place_item.dart';
import 'add_new_plase_page.dart';

class FavoritePlacesPage extends StatelessWidget {
  const FavoritePlacesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Favorite Places',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, state) {
          if (state is PlaceLoadingState)
            {
              return const CircularProgressIndicator();
            }
          if (state is PlaceLoadedState) {
            return ListView.builder(
              itemBuilder: (_, i) => PlaceItem(place: state.places[i],),
              itemCount: state.places.length);
          }
          return const SizedBox() ;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddNewPlace()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
