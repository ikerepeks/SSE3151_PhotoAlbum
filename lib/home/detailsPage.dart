import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/models/picture.dart';
import 'package:photo_album/services/screensize.dart';
import 'package:photo_album/shared/constants.dart';

class Details extends StatefulWidget {
  Picture pic;

  Details({this.pic});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String desc;

  final CollectionReference photoStore =
      Firestore.instance.collection('images');

  void _editDesc() {
    photoStore.document(widget.pic.filename).setData(
        {'name': widget.pic.filename, 'desc': desc, 'url': widget.pic.url});
  }

  void _deleteFile() async {
    await photoStore.document(widget.pic.filename).delete();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editDesc();
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteFile();
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text(widget.pic.filename),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: screenHeightExcludingToolbar(context, dividedBy: 3),
                child: Image.network(
                  widget.pic.url,
                  fit: BoxFit.cover,
                ),
              ),
              Text('Image Description',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: widget.pic.desc),
                  onChanged: (value) {
                    setState(() {
                      desc = value;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
