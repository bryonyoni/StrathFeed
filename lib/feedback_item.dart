import 'package:flutter/material.dart';

class FeedbackItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      height: 90,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Material(
        color: Colors.white,
        elevation: 3,
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Friday, 22 Nov',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text('Floor is full of water and is very slippery',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black45
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text('At: 2 floor sbs building lavatories',
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.black45
                      ),

                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 90,
                  child: Image(image: AssetImage('assets/frown_face.png'),
                    height: 35,
                    width: 35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}