import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FStoreSaver extends StatelessWidget {
  @override
  String filename, desc, location;
  FStoreSaver({this.filename, this.desc, this.location});

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

    //upload to firestore
    photoStore.document(filename).setData(
        {'name': filename, 'desc': desc, 'url': url, 'location': location});
  }

  Widget build(BuildContext context) {
    _startUpload();
    return Text('Succesful');
  }
}
