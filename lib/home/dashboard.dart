import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photo_album/home/addimage.dart';
import 'package:photo_album/home/pictureView.dart';
import 'package:photo_album/models/picture.dart';
import 'package:photo_album/services/pictureget.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //show modal for adding picture
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return ImageCapture();
          });
    }

    return Scaffold(
      //backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text('Home Page'),
      ),
      body: StreamProvider<List<Picture>>.value(
        value: GetPicture().pic,
        // builder: (context, AsyncSnapshot<List<Picture>> snapshot) {
        //   if (snapshot.hasData) {
        // return
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // First Column
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  PictureView(
                    position: 0,
                  ),
                  PictureView(
                    position: 1,
                  ),
                ],
              ),
              // Second Column
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  PictureView(
                    position: 2,
                  ),
                  PictureView(
                    position: 3,
                  )
                ],
              )
            ],
          ),
        ),
      ),
      // } else {
      //   return Center(child: Text('Nothing to see here'));
      // }
      // },
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showSettingsPanel();
        },
        icon: Icon(Icons.add),
        label: Text('Add Photo'),
        elevation: 50.0,
        backgroundColor: Colors.blue,
      ),
    );
  }
}
