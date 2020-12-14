import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photo_album/home/addimage.dart';
import 'package:photo_album/models/picture.dart';
import 'package:photo_album/services/pictureget.dart';
import 'package:photo_album/services/screensize.dart';

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
      body: StreamBuilder<List<Picture>>(
        stream: GetPicture().pic,
        builder: (context, AsyncSnapshot<List<Picture>> snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // First Column
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: screenWidth(context, dividedBy: 2),
                        height:
                            screenHeightExcludingToolbar(context, dividedBy: 3),
                        padding: EdgeInsets.all(50.0),
                        child: Text(snapshot.toString()),
                        // child: Image.network(
                        //   snapshot.data.toString(),
                        //   fit: BoxFit.cover,
                        //)
                      ),
                      Container(
                          width: screenWidth(context, dividedBy: 2),
                          height: screenHeightExcludingToolbar(context,
                              dividedBy: 3),
                          padding: EdgeInsets.all(50.0),
                          child: Image.network(
                            snapshot.data.toString(),
                            fit: BoxFit.cover,
                          ))
                    ],
                  ),
                  // Second Column
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                          width: screenWidth(context, dividedBy: 2),
                          height: screenHeightExcludingToolbar(context,
                              dividedBy: 3),
                          padding: EdgeInsets.all(50.0),
                          child: Image.network(
                            snapshot.data.toString(),
                            fit: BoxFit.cover,
                          )),
                      Container(
                          width: screenWidth(context, dividedBy: 2),
                          height: screenHeightExcludingToolbar(context,
                              dividedBy: 3),
                          padding: EdgeInsets.all(50.0),
                          child: Image.network(
                            snapshot.data.toString(),
                            fit: BoxFit.cover,
                          ))
                    ],
                  )
                ],
              ),
            );
          } else {
            return Center(child: Text('Nothing to see here'));
          }
        },
      ),
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
