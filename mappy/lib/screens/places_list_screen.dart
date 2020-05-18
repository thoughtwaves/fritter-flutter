import 'package:flutter/material.dart';
import 'package:mappy/providers/great_places.dart';
import 'package:mappy/screens/place_details_screen.dart';
import './add_places_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Places'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            )
          ],
        ),
        body: //Center(child: CircularProgressIndicator(),),
            FutureBuilder(
          future:
              Provider.of<GreatPlaces>(context, listen: false).fetchFromDB(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatPlaces>(
                  builder: (ctx, greatPlaces, child) => greatPlaces
                              .places.length ==
                          0
                      ? child
                      : ListView.builder(
                          itemCount: greatPlaces.places.length,
                          itemBuilder: (ctx, index) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(greatPlaces.places[index].image),
                            ),
                            title: Text(greatPlaces.places[index].title),
                            subtitle: Text(
                                greatPlaces.places[index].location.address),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PlaceDetails(),
                                  settings: RouteSettings(
                                      arguments: greatPlaces.places[index])));
                            },
                          ),
                        ),
                  child: Center(
                    child: Text('Nothing at all'),
                  ),
                ),
        ));
  }
}
