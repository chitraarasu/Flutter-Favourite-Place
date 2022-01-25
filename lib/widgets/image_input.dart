import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

enum imagePic {
  camera,
  gallary,
}

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  var imageFile;
  Future _takePicture(button) async {
    if (button == imagePic.camera) {
      imageFile = await ImagePicker.platform.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );
    } else {
      imageFile = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
      );
    }
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(imageFile.path);
    final savedImage =
        await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150.0,
          height: 100.0,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  "No Image Taken",
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Column(
            children: [
              TextButton.icon(
                onPressed: () {
                  _takePicture(imagePic.camera);
                },
                icon: Icon(Icons.camera),
                label: Text("Take Picture"),
                // style: T,
              ),
              TextButton.icon(
                onPressed: () {
                  _takePicture(imagePic.gallary);
                },
                icon: Icon(Icons.image),
                label: Text("Choose Picture"),
                // style: T,
              )
            ],
          ),
        ),
      ],
    );
  }
}
