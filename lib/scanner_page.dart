import 'dart:convert';
import 'package:feed/sentiment_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:feed/location.dart';
import 'package:permission/permission.dart';
import 'package:flutter_qr_reader/qrcode_reader_view.dart';
import 'package:vibrate/vibrate.dart';


class ScannerPage extends StatefulWidget {
  ScannerPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ScannerPageState createState() => _ScannerPageState();

}

class _ScannerPageState extends State<ScannerPage> {

  @override
  Widget build(BuildContext context) {
//    var permissions = await Permission.requestSinglePermission(PermissionName.Camera);
    return Scaffold(
      body: QrcodeReaderView(key: qrViewKey, onScan: onScan, helpWidget: Text("Just point the camera at the qr-code"),),
    );
  }

   requestPermissions() async {
    List<PermissionName> permissionNames = [];
    permissionNames.add(PermissionName.Camera);
    var permissions = await Permission.requestPermissions(permissionNames);
    print(permissions.toString());
  }

  GlobalKey<QrcodeReaderViewState> qrViewKey = GlobalKey();

  Future<void> showDialogForFoundLocation(Location user) async {
    bool canVibrate = await Vibrate.canVibrate;
    String found = "We've found you!";
    if(canVibrate){
      var _type = FeedbackType.success;
      Vibrate.feedback(_type);
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(found),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(user.name),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('sentiment-page');
              },
            ),
          ],
        );
      },
    );
  }

  Future onScan(String data) async {
    try {
      print('Weve got something');
      String decoded = utf8.decode(base64.decode(data));
      print(decoded);
      Map userMap = jsonDecode(decoded);
      print(userMap.toString());
      var user = Location.fromJson(userMap);
      Location.location = user;
      await showDialogForFoundLocation(user);
      qrViewKey.currentState.startScan();

    } catch (e) {

    }

  }
}