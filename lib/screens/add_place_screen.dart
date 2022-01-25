import 'dart:io';

import 'package:favouriteplace/models/place.dart';
import 'package:favouriteplace/providers/great_places.dart';
import 'package:favouriteplace/widgets/image_input.dart';
import 'package:favouriteplace/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add-place";

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;
  _selectImage(pickedImage) {
    _pickedImage = pickedImage;
  }

  _selectPlace(lat, lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, _pickedLocation!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a New Place"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: const Icon(Icons.add),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ).copyWith(
              backgroundColor: MaterialStateProperty.all(Colors.yellow),
              foregroundColor: MaterialStateProperty.all(Colors.black),
            ),
            label: const Text("Add Place"),
          ),
        ],
      ),
    );
  }
}
