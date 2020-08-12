import 'package:flutter/material.dart';
import 'package:location_map/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

import './providers/great_places.dart';
import 'screens/places_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'GReate places',
        theme: ThemeData(
            accentColor: Colors.amberAccent, primaryColor: Colors.greenAccent),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
        },
      ),
    );
  }
}
