import 'package:flutter/material.dart';
import 'package:photo_album/home/detailsPage.dart';
import 'package:photo_album/models/picture.dart';
import 'package:photo_album/services/screensize.dart';
import 'package:provider/provider.dart';

class PictureView extends StatelessWidget {
  int position;
  PictureView({this.position});

  @override
  Widget build(BuildContext context) {
    final pic = Provider.of<List<Picture>>(context) ?? [];
    pic.forEach((element) {
      print(element.filename);
      print(element.desc);
      print(element.url);
      print(element.location);
    });

    return InkWell(
      child: Container(
          width: screenWidth(context, dividedBy: 2),
          height: screenHeightExcludingToolbar(context, dividedBy: 3),
          padding: EdgeInsets.all(50.0),
          child: Image.network(
            pic[position].url,
            fit: BoxFit.cover,
          )),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Details(
                      pic: pic[position],
                    )));
      },
    );
  }
}
