import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../screens/map_screen.dart';
import '../helpers/location_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  final Function _selectPlace;

  LocationInput(this._selectPlace);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  var _previewImageUrl;

  void _showLocationPreview(double lat, double long) {
    final staticMapUrl = LocationHelper.getLocationPreviewImage(lat, long);
    setState(() {
      _previewImageUrl = staticMapUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final location = await Location().getLocation();
      _showLocationPreview(location.latitude, location.longitude);
      widget._selectPlace(location.latitude, location.longitude);
    } catch (err) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => MapScreen(
                  isSelecting: true,
                )));
    if (selectedLocation == null) return;
    print(selectedLocation.longitude);
    _showLocationPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget._selectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 170,
        decoration: BoxDecoration(border: Border.all(width: 1)),
        width: double.infinity,
        alignment: Alignment.center,
        child: _previewImageUrl == null
            ? Text(
                'No location',
                textAlign: TextAlign.center,
              )
            : Image.network(
                _previewImageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.location_on),
            label: Text('Current Location'),
            onPressed: _getCurrentLocation,
          ),
          FlatButton.icon(
            icon: Icon(Icons.map),
            label: Text('Select on Map'),
            onPressed: _selectOnMap,
          )
        ],
      )
    ]);
  }
}
