import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_album/services/uploader.dart';
import 'package:photo_album/shared/constants.dart';

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;
  String desc;

  // select image via gallery/camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  // Remove Image
  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(Icons.photo_album),
              onPressed: () => _pickImage(ImageSource.gallery),
            )
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          if (_imageFile != null) ...[
            Image.file(_imageFile),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton.icon(
                  label: Text('Retake'),
                  icon: Icon(Icons.refresh),
                  onPressed: _clear,
                )
              ],
            ),
            TextFormField(
              decoration: textInputDecoration.copyWith(
                  hintText: 'Enter Image Description'),
              validator: (value) => value.isEmpty ? 'Enter Description' : null,
              onChanged: (value) {
                setState(() {
                  desc = value;
                });
              },
            ),
            Uploader(
              file: _imageFile,
              desc: desc,
            )
          ]
        ],
      ),
    );
  }
}
