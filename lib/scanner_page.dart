import 'dart:convert';
import 'package:feed/sentiment_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:feed/location.dart';

import 'package:flutter_qr_reader/qrcode_reader_view.dart';


class ScannerPage extends StatefulWidget {
  ScannerPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ScannerPageState createState() => _ScannerPageState();

}

class _ScannerPageState extends State<ScannerPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QrcodeReaderView(key: qrViewKey, onScan: onScan, helpWidget: Text("Just point the camera at the qr-code"),),
    );
  }

  GlobalKey<QrcodeReaderViewState> qrViewKey = GlobalKey();

  Future onScan(String data) async {
    try {
      print('Weve got something');
      String decoded = utf8.decode(base64.decode(data));
      print(decoded);
      Map userMap = jsonDecode(decoded);
      print(userMap.toString());
      var user = Location.fromJson(userMap);
      Location.location = user;
      await showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("We've found you!"),
            content: Text(user.name),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Continue"),
                onPressed: ((){
                  Navigator.of(context).pushNamed('sentiment-page');
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => SentimentPage(location: user,)),
//                  );
//                  Navigator.pop(context);
                }),
              )
            ],
          );
        },
      );
      qrViewKey.currentState.startScan();

    } catch (e) {

    }

  }
}