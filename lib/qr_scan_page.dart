import 'package:feed/feedback_item.dart';
import 'package:feed/location.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:barcode_scan/barcode_scan.dart';

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
    // getSinglePermissionStatus();
    // requestPermissions();
    final continueButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
        onPressed: () {},
        child:InkWell(onTap: (){
          Navigator.of(context).pushNamed('scan-page');
        },child: Text("Continue.",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold))),
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(30, 60, 30, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: 10.0),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: InkWell(onTap: (){
//                    Navigator.of(context).pushNamed('scan-page');
                    requestPermissions();
                  },child: Image(image: AssetImage('assets/scan_qr.png'),
                    height: 250,
                    width: 250,
                  ),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(barcode,
                  style: TextStyle(
                      fontSize: 12
                  ),
                ),
//                SizedBox(height: 500.0),

              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(30, 40, 30, 20),
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
    );


  }


  requestPermissions() async {
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    print(permission.toString());

    if(permission.toString() != "PermissionStatus.granted"){
      Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.camera]);
      requestPermissions();
    }else{
      Navigator.of(context).pushNamed('scan-page');
    }

  }

//  Future scan() async {
//    try {
//      String barcode = await BarcodeScanner.scan();
//      setState(() {
//        String decoded = utf8.decode(base64.decode(barcode));
//
//        Map userMap = jsonDecode(decoded);
//        var user = Location.fromJson(userMap);
//        return this.barcode = user.name;
//      });
//
//    } on PlatformException catch (e) {
//      if (e.code == BarcodeScanner.CameraAccessDenied) {
//        setState(() {
//          this.barcode = 'The user did not grant the camera permission!';
//        });
//      } else {
//        setState(() => this.barcode = 'Unknown error: $e');
//      }
//    } on FormatException{
//      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
//    } catch (e) {
//      setState(() => this.barcode = 'Unknown error: $e');
//    }
//  }

}