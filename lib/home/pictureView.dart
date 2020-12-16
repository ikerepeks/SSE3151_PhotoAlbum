import 'package:flutter/material.dart';
import 'package:photo_album/models/picture.dart';
import 'package:photo_album/services/pictureget.dart';
import 'package:photo_album/services/screensize.dart';
import 'package:provider/provider.dart';

class PictureView extends StatefulWidget {
  @override
  _PictureViewState createState() => _PictureViewState();
}

class _PictureViewState extends State<PictureView> {
  @override
  Widget build(BuildContext context) {
    final pic = Provider.of<List<Picture>>(context) ?? [];
    pic.forEach((element) {
      print(element.filename);
      print(element.desc);
    });

    return Container(
      width: screenWidth(context, dividedBy: 2),
      height: screenHeightExcludingToolbar(context, dividedBy: 3),
      padding: EdgeInsets.all(50.0),
      child:
          // Image.network(
          //   GetPicture.loadImage(context, pic[1].filename.toString()).toString(),
          //   fit: BoxFit.cover,
          // )
          Text('This is ' + pic[0].filename.toString()),
    );
  }
}
