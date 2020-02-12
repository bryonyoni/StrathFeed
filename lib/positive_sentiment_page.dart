import 'package:feed/feedback_item.dart';
import 'package:flutter/material.dart';

class PositiveSentimentPage extends StatefulWidget {
  PositiveSentimentPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyPositiveSentimentPageState createState() => _MyPositiveSentimentPageState();

}

class _MyPositiveSentimentPageState extends State<PositiveSentimentPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);

  @override
  Widget build(BuildContext context) {

    final explanationField = TextField(
      obscureText: false,
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

    final continueButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(

        padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
        onPressed: () {},
        child:InkWell(onTap: (){
          Navigator.of(context).pushNamed('feedback-sent-page');
        },child: Text("Submit.",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold))),
      ),
    );

    return Scaffold(
      body: Container(
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
                Text('What do you really Like about here?',
                    style: TextStyle(color: Colors.blue,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)
                ),
                SizedBox(height: 20.0),
                Text('You May Be As Descriptive As You Like.',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    )
                ),
                SizedBox(height: 30.0),
                explanationField,
              ],
            ),

            SizedBox(height: 500.0),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
      ),
    );

  }
}