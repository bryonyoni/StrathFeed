import 'package:feed/feedback_item.dart';
import 'package:feed/sent_message_item.dart';
import 'package:feed/sentiment_expanation_item.dart';
import 'package:flutter/material.dart';

class FeedChatPage extends StatefulWidget {
  FeedChatPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyFeedChatPageState createState() => _MyFeedChatPageState();

}

class _MyFeedChatPageState extends State<FeedChatPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Text('Feed Chat.\nTalk to us directly.',
                  style: TextStyle(color: Colors.blue,
                      fontSize: 23,
                      fontWeight: FontWeight.bold)
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height-200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SentMessageItem(),
                ],
              ),
            ),
            Container(
              height: 70,
              color: Colors.white30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width-70,
                    child: TextField(
                      obscureText: false,
                      style: style,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: InputBorder.none,
                          hoverColor: Colors.blue,
                          hintText: "Say Something...",
                          hintStyle: TextStyle(
                              color: Colors.black54
                          )
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Text('Send.',
                        style: TextStyle(color: Colors.blue,
                            fontSize: 15,
                        )
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

  }
}