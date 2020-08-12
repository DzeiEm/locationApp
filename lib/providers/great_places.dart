import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import '../models/place.dart';
import 'dart:io';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  // pasidarom copy, kad galima butu pasiekti is kito file'o
  // in return --> grazink copy is originalaus _items
  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: pickedImage,
        location: null,
        title: pickedTitle);
    _items.add(newPlace);
    notifyListeners();
  }
}
