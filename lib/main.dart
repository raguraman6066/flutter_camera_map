import 'package:flutter/material.dart';
import 'package:native_features_flutter/providers/user_places.dart';
import 'package:native_features_flutter/screens/add_place.dart';
import 'package:native_features_flutter/screens/places_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserPlaces(), //provider class
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlaceList(),
        routes: {
          AddPlace.routeName: (context) => AddPlace(),
        },
      ),
    );
  }
}
