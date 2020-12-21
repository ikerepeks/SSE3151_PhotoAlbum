import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FStoreSaver extends StatelessWidget {
  @override
  String filename, desc;
  FStoreSaver({this.filename, this.desc});

  final CollectionReference photoStore =
      Firestore.instance.collection('images');

  //upload filename,desc and url to firestore
  void _startUpload() async {
    dynamic url = await FirebaseStorage.instance
        .ref()
        .child('images')
        .child(filename)
        .getDownloadURL();
    print('This is the ' + url.toString());

    photoStore
        .document(filename)
        .setData({'name': filename, 'desc': desc, 'url': url});
  }

  Widget build(BuildContext context) {
    _startUpload();
    return Text('Succesful');
  }
}
