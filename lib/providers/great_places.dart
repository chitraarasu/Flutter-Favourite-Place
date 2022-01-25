import 'dart:io';

import 'package:favouriteplace/helpers/db_helper.dart';
import 'package:favouriteplace/helpers/location_helper.dart';
import 'package:flutter/foundation.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  addPlace(title, image, PlaceLocation locationData) async {
    // final address = await LocationHelper.getPlaceAddress(
    //   locationData.latitude,
    //   locationData.longitude,
    // );
    final updatedLocation = PlaceLocation(
      latitude: locationData.latitude,
      longitude: locationData.longitude,
      // address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: updatedLocation,
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insertData("user_places", {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      // 'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlace() async {
    List dataList = await DBHelper.fetchData("user_places");
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            location: PlaceLocation(
              longitude: item['loc_lat'],
              latitude: item['loc_lng'],
              // address: item['address'],
            ),
            image: File(
              item['image'],
            ),
          ),
        )
        .toList();

    notifyListeners();
  }

  findById(Object? id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
