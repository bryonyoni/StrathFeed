import 'package:flutter/material.dart';

class SentimentExplanationItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Material(
        color: Colors.white,
        elevation: 3,
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('There is a foul Smell here',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              SizedBox(width: 80.0),
              Image(image: AssetImage('assets/check_blue.png'),
                height: 20,
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

}