import 'package:feed/feedback_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<HomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('StrathFeed',
                    style: TextStyle(color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)
                ),
                InkWell(onTap: (){
                  Navigator.of(context).pushNamed('feed-chat-page');
                },child: Image(image: AssetImage('assets/chat_icon.png'),
                    height: 35,
                    width: 35,
                  ),
                )
              ],
            ),
            SizedBox(height: 30.0),
            Container(
              width: double.infinity,
              child: InkWell(onTap: (){
                Navigator.of(context).pushNamed('qr-scan-page');
              },child: Material(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Raise a New Issue in \nthe School.',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(height: 30.0),

                          Text('Give some Feedback',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text('Your Feedback History.',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            FeedbackItem(),
            FeedbackItem(),
            FeedbackItem(),
          ],
        ),
      ),
    );
  }
}