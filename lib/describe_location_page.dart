import 'package:feed/feedback_item.dart';
import 'package:feed/sentiment_page.dart';
import 'package:flutter/material.dart';

import 'location.dart';

class DescribeLocationPage extends StatefulWidget {
  DescribeLocationPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyDescribeLocationPageState createState() => _MyDescribeLocationPageState();

}

class _MyDescribeLocationPageState extends State<DescribeLocationPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
  final TextEditingController _textController =  TextEditingController();

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
          String location = _textController.text.toString();
          Location.location = Location(location, "boi@guam.com",'lavatory');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SentimentPage()),
          );
        },child: Text("Submit.",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold))),
      ),
    );

    final descriptionField = TextField(
      obscureText: false,
      controller: _textController,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hoverColor: Colors.blue,
        hintText: "Say Something...",
        hintStyle: TextStyle(
          color: Colors.blue
        )
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(40, 70, 40, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Describe where you think you are.',
                        style: TextStyle(color: Colors.blue,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)
                    ),
                    SizedBox(height: 10.0),
                    Text('For instance: Second floor lavatory, near the '
                        'Telecommunications Lab, Phase 1 Building.',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        )
                    ),
                    SizedBox(height: 10.0),
                    descriptionField,
                  ],
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.fromLTRB(10, 0, 40, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(height: 20.0),
                continueButton,
              ],
            ),
          )
        ],
      ),
    );

  }
}