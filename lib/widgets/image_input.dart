import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as systemPath;

class ImageInput extends StatefulWidget {
  final Function onSelectImg;
  ImageInput(this.onSelectImg);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  var _storedImage; //take and store here

  //method for taking pic
  Future<void> _takePicture() async {
    //initialize and get pic
    final imagePicker = ImagePicker();
    final imageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    //set taken image to outside variable
    setState(() {
      _storedImage = File(imageFile.path);
    });
    //take where want to store
    final addDir = await systemPath.getApplicationDocumentsDirectory();
    String appDocDir = addDir.path;

    final fileName =
        path.basename(imageFile.path); //get name from temp saved loc using path
    final File saveImage = await _storedImage.copy('$appDocDir/$fileName');
    widget
        .onSelectImg(saveImage); //execute this fun to pass img to another page
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
              border: Border.all(
            width: 1,
            color: Colors.grey,
          )),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No image taken ',
                  textAlign: TextAlign.center,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        TextButton.icon(
            icon: Icon(Icons.camera),
            onPressed: () {
              _takePicture();
            },
            label: Text('Take Picture'))
      ],
    );
  }
}
