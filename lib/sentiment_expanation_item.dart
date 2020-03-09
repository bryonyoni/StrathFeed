import 'dart:collection';

import 'package:feed/feedback.dart';
import 'package:flutter/material.dart';

class SentimentExplanationItem extends StatelessWidget {
  final sugestedItem item;
  SentimentExplanationItem({this.item});

  Widget image(){
    if(item.isSelected){
      return Image(image: AssetImage('assets/check_blue.png'),
        height: 20,
        width: 20,
      );
    }else{
      return Image(image: AssetImage('assets/check_grey.png'),
        height: 20,
        width: 20,
      );
    }
  }

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
              Text(item.text,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              SizedBox(width: 80.0),
              image(),
            ],
          ),
        ),
      ),
    );
  }

}