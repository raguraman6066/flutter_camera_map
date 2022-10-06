import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:native_features_flutter/helper/location_helper.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> getCurrentLocation() async {
    final locData = await Location().getLocation();
    try {
      final staticMapImageUrl = LocationHelper.generateLocationImage(
          latitude: locData.latitude!, longitude: locData.longitude!);
      setState(() {
        _previewImageUrl = staticMapImageUrl;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          child: _previewImageUrl != null
              ? Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Location Choosen',
                  textAlign: TextAlign.center,
                ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.location_on),
              onPressed: () {
                getCurrentLocation();
              },
              label: Text('Current Location'),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.map),
              onPressed: () {},
              label: Text('Select on Location'),
            ),
          ],
        )
      ],
    );
  }
}
