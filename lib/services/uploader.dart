import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:photo_album/services/fstoreSaver.dart';

class Uploader extends StatefulWidget {
  final File file;
  final String desc;
  final String location;
  Uploader({Key key, this.file, this.desc, this.location}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  String filename;

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://photo-album-7918f.appspot.com');

  final CollectionReference photoStore =
      Firestore.instance.collection('images');

  StorageUploadTask _uploadTask;

  void _startUpload() async {
    filename = DateTime.now().toString();
    setState(() {
      //store in firebase storage
      _uploadTask =
          _storage.ref().child('images/' + filename).putFile(widget.file);
    });

    // store in firestore
    // photoStore
    //     .document(filename)
    //     .setData({'name': filename, 'desc': widget.desc});
  }

  @override
  Widget build(BuildContext context) {
    // if image is uploading
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;

          double progressPercent =
              event != null ? event.bytesTransferred / event.totalByteCount : 0;

          return Column(
            children: [
              // success
              if (_uploadTask.isComplete)
                FStoreSaver(
                    filename: filename,
                    desc: widget.desc,
                    location: widget.location),
              // paused
              if (_uploadTask.isPaused)
                FlatButton(
                  child: Icon(Icons.play_arrow),
                  onPressed: _uploadTask.resume,
                ),
              // in progress
              if (_uploadTask.isInProgress)
                FlatButton(
                  child: Icon(Icons.pause),
                  onPressed: _uploadTask.pause,
                ),

              // Loading Bar %
              Container(
                  padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 10.0),
                  child: LinearPercentIndicator(
                    center:
                        Text('${(progressPercent * 100).toStringAsFixed(2)} %'),
                    lineHeight: 20.0,
                    percent: progressPercent,
                    progressColor: Colors.blue,
                    backgroundColor: Colors.grey,
                  )),
            ],
          );
        },
      );
    }

    // picture not uploading
    else {
      return FlatButton.icon(
        label: Text('Upload to Firebase'),
        icon: Icon(Icons.cloud_upload),
        onPressed: _startUpload,
      );
    }
  }
}
