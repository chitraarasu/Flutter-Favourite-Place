import 'package:favouriteplace/providers/great_places.dart';
import 'package:favouriteplace/screens/add_place_screen.dart';
import 'package:favouriteplace/screens/place_detail_screen.dart';
import 'package:favouriteplace/screens/places_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
            primarySwatch: Colors.indigo, primaryColor: Colors.indigo),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
