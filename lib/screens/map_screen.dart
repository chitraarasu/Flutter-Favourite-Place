import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final Lat;
  final Lon;
  final bool isSelecting;

  MapScreen({
    this.isSelecting = false,
    this.Lat,
    this.Lon,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickerLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickerLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickerLocation == null
                  ? null
                  : () {
                      Navigator.pop(context, _pickerLocation);
                    },
              icon: Icon(Icons.check),
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.Lat,
            widget.Lon,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (_pickerLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: _pickerLocation ?? LatLng(widget.Lat, widget.Lon),
                ),
              },
      ),
    );
  }
}
