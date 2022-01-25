import 'package:favouriteplace/providers/great_places.dart';
import 'package:favouriteplace/screens/add_place_screen.dart';
import 'package:favouriteplace/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlace(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<GreatPlaces>(
              builder: (BuildContext context, value, Widget? child) =>
                  value.items.isEmpty
                      ? child!
                      : ListView.builder(
                          itemCount: value.items.length,
                          itemBuilder: (ctx, i) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(value.items[i].image),
                            ),
                            title: Text(value.items[i].title),
                            // subtitle: Text(value.items[i].location.address),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PlaceDetailScreen.routeName,
                                arguments: value.items[i].id,
                              );
                            },
                          ),
                        ),
              child: const Center(
                child: Text("Got no places yet, start adding some!"),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
