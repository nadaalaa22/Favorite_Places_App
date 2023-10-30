import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/place_bloc.dart';
import '../widgets/place_item.dart';
import 'add_new_place_page.dart';

class FavoritePlacesPage extends StatefulWidget {
  const FavoritePlacesPage({Key? key}) : super(key: key);

  @override
  State<FavoritePlacesPage> createState() => _FavoritePlacesPageState();
}

class _FavoritePlacesPageState extends State<FavoritePlacesPage> {
  @override
  void initState() {
    super.initState();
    context.read<PlaceBloc>().add(GetPlaceEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Favorite Places',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, state) {
          if (state is PlaceLoadingState)
            {
              return const Center(child: CircularProgressIndicator());
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
