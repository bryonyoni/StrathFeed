import 'package:feed/feedback_item.dart';
import 'package:feed/location.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';

class QRScanPage extends StatefulWidget {
  QRScanPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyQRScanPageState createState() => _MyQRScanPageState();

}

class _MyQRScanPageState extends State<QRScanPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
  String barcode = "";


  @override
  Widget build(BuildContext context) {

    final continueButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(

        padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
        onPressed: () {},
        child:InkWell(onTap: (){
          Navigator.of(context).pushNamed('sentiment-page');
        },child: Text("Continue.",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold))),
      ),
    );

    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(30, 40, 30, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('StrathFeed',
                    style: TextStyle(color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)
                ),
                SizedBox(height: 10.0),
                Text('Quick scan the code to find out where you are.',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    )
                ),
              ],
            ),

            SizedBox(height: 30.0),

            InkWell(onTap: (){
              scan();
            },child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(25.0),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    width: double.infinity,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Open Scanner',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16
                          ),
                        ),
                        Text('-->',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ),
            SizedBox(height: 20.0),
            Text(barcode,
              style: TextStyle(
                  fontSize: 12
              ),
            ),
            SizedBox(height: 500.0),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(onTap: (){
                    Navigator.of(context).pushNamed('describe-location-page');
                  },child:Text('Type your location \ninstead.',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14
                      ),
                    ),
                  ),
                  continueButton,
                ],
              ),
            )
          ],
        ),
      ),
    );


  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        String decoded = utf8.decode(base64.decode(barcode));

        Map userMap = jsonDecode(decoded);
        var user = Location.fromJson(userMap);
        return this.barcode = user.name;
      });

    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

}