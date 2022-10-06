import 'package:flutter/material.dart';
import 'package:native_features_flutter/helper/db_helper.dart';
import 'package:native_features_flutter/models/user_place.dart';
import 'dart:io';

class UserPlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items {
    return [..._items];
  }

  addPlace(String title, File pickedImg) {
    final newPlace = Place(DateTime.now().toString(), title, pickedImg);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    dataList.map((e) => Place(e['id'], e['title'], File(e['image']))).toList();
    notifyListeners();
  }
}
