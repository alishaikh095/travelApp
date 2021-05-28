import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    var imageFile;
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.2,
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () async {
                Navigator.pop(context);
                imageFile = await ImagePicker().getImage(
                  source: ImageSource.camera,
                  maxWidth: 600,
                );
                setState(() {
                  _storedImage = File(imageFile.path);
                });
                // saveImageFile(imageFile);
                final appDir =
                    await syspaths.getApplicationDocumentsDirectory();
                final fileName = path.basename(imageFile.path);

                final savedImage =
                    await File(imageFile.path).copy('${appDir.path}/$fileName');
                widget.onSelectImage(savedImage);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);
                imageFile = await ImagePicker().getImage(
                  source: ImageSource.gallery,
                  maxWidth: 600,
                );
                setState(() {
                  _storedImage = File(imageFile.path);
                });
                print(imageFile.path);
                final appDir =
                    await syspaths.getApplicationDocumentsDirectory();
                final fileName = path.basename(imageFile.path);

                final savedImage =
                    await File(imageFile.path).copy('${appDir.path}/$fileName');
                widget.onSelectImage(savedImage);
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            icon: Icon(Icons.camera),
            label: Text(
              'Take Picture',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
