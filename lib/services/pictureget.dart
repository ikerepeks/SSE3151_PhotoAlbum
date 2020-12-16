import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:photo_album/models/picture.dart';

class GetPicture extends ChangeNotifier {
  final CollectionReference picCollection =
      Firestore.instance.collection('images');

  GetPicture();

  static Future<String> loadImage(BuildContext context, String filename) async {
    dynamic url = await FirebaseStorage.instance
        .ref()
        .child('images')
        .child(filename)
        .getDownloadURL();
    print('This is the ' + url.toString());
    return url;
  }

  // convert to list from snapshot
  List<Picture> _picFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Picture(
        filename: doc.data['name'] ?? 'test',
        desc: doc.data['desc'] ?? 'test',
      );
    }).toList();
  }

  // get streams of data
  Stream<List<Picture>> get pic {
    return picCollection.snapshots().map(_picFromSnapshot);
  }

  // if (_uploadTask.isComplete) {
  //     print('reached here 2' + filename);

  //     dynamic url = await FirebaseStorage.instance
  //         .ref()
  //         .child('images')
  //         .child(filename)
  //         .getDownloadURL();

  //     print('This is the ' + filename);
  //     photoStore.document(filename).setData({'url': url.toString()});
  //   }
}
