import 'package:flutter/material.dart';
import 'package:native_features_flutter/providers/user_places.dart';
import 'package:native_features_flutter/screens/add_place.dart';
import 'package:provider/provider.dart';

class PlaceList extends StatelessWidget {
  const PlaceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddPlace.routeName);
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<UserPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<UserPlaces>(
                    builder: (context, places, ch) => places.items.length <= 0
                        ? const Center(
                            child: Text('No places added yet'),
                          )
                        : ListView.builder(
                            itemCount: places.items.length,
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(places.items[index].image),
                              ),
                              title: Text(places.items[index].title),
                              onTap: () {
                                //go to detail page
                              },
                            ),
                          ),
                  ),
      ),
    );
  }
}
