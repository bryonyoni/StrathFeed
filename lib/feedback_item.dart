import 'package:feed/feedback.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeedbackItem extends StatelessWidget {
  final myFeedback feedbackData;

  FeedbackItem({this.feedbackData});

   Widget image(){
    if(feedbackData.sentiment=="positive"){
      return Image(image: AssetImage('assets/happy_face.png'),
                    height: 35,
                    width: 35,
                  );
    }else{
      return Image(image: AssetImage('assets/frown_face.png'),
                    height: 35,
                    width: 35,
                  );
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      height: 90,
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Material(
        color: Colors.white,
        elevation: 2,
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
                  Text(feedbackData.timeOfSending!=null ? DateFormat.yMMMMEEEEd('en_US').format(feedbackData.timeOfSending):"Friday 22 Nov",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(feedbackData.description,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black45
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(feedbackData.location.name,
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
                  child: image(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}