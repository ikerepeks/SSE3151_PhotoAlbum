import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/models/picture.dart';

class GetPicture extends ChangeNotifier {
  final Query picCollection =
      Firestore.instance.collection('images').orderBy('name', descending: true);

  GetPicture();

  // convert to list from snapshot
  List<Picture> _picFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Picture(
          filename: doc.data['name'] ?? 'test',
          desc: doc.data['desc'] ?? 'test',
          url: doc.data['url'] ?? 'test',
          location: doc.data['location'] ?? 'test');
    }).toList();
  }

  // get streams of data
  Stream<List<Picture>> get pic {
    return picCollection.snapshots().map(_picFromSnapshot);
  }
}
