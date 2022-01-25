import 'package:favouriteplace/helpers/location_helper.dart';
import 'package:favouriteplace/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  Function onSelectPlace;
  LocationInput(this.onSelectPlace);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  _preview(latitude, longitude) {
    final staticMapImageUrl =
        LocationHelper.locationPreviewImage(latitude, longitude);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      _preview(locData.latitude, locData.longitude);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (e) {
      return;
    }
  }

  Future _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return MapScreen(
            Lat: 0.0,
            Lon: 0.0,
            isSelecting: true,
          );
        },
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _preview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? const Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              icon: const Icon(
                Icons.location_on,
              ),
              label: Text(
                'Current Location',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onPressed: _getCurrentUserLocation,
            ),
            TextButton.icon(
              icon: const Icon(
                Icons.map,
              ),
              label: Text(
                'Select on Map',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
