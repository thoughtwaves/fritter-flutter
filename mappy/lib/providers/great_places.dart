import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mappy/helpers/location_helper.dart';
import '../helpers/db_helper.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    final address = await LocationHelper.getPlaceAddress(
        location.latitude, location.longitude);
    final updatedLocation = PlaceLocation(
        latitude: location.latitude,
        longitude: location.longitude,
        address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        image: image,
        location: updatedLocation);
    _places.add(newPlace);
    notifyListeners();
    DBHelper.insert('places', {
      'id': newPlace.id,
      'image': newPlace.image.path,
      'title': newPlace.title,
      'latitude': updatedLocation.latitude,
      'longitude': updatedLocation.longitude,
      'address': updatedLocation.address
    });
  }

  Future<void> fetchFromDB() async {
    final placesList = await DBHelper.getData('places');
    _places = placesList
        .map((item) => Place(
            id: item['id'],
            image: File(item['image']),
            location: PlaceLocation(
                latitude: item['latitude'],
                longitude: item['longitude'],
                address: item['address']),
            title: item['title']))
        .toList();
    notifyListeners();
  }
}
