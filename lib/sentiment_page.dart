import 'package:feed/feedback_item.dart';
import 'package:flutter/material.dart';

class SentimentPage extends StatefulWidget {
  SentimentPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MySentimentPageState createState() => _MySentimentPageState();

}

class _MySentimentPageState extends State<SentimentPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);

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
          Navigator.of(context).pushNamed('homepage');
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
        padding: EdgeInsets.fromLTRB(40, 70, 40, 20),
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
                Text('At: the second floor lavatories, in Sbs building',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    )
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: <Widget>[
                  InkWell(onTap: (){
                    Navigator.of(context).pushNamed('negative-sentiment-page');
                    },child: Image(image: AssetImage('assets/frown_face.png'),
                        height: 100,
                        width: 100,
                      ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Mostly Dissapointed.',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 22,
                            )
                        ),
                        SizedBox(height: 10.0),
                        Text('Theres a problem',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                children: <Widget>[
                  InkWell(onTap: (){
                    Navigator.of(context).pushNamed('positive-sentiment-page');
                  },child: Image(image: AssetImage('assets/happy_face.png'),
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Really Satisfied.',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 22,
                            )
                        ),
                        SizedBox(height: 10.0),
                        Text('Everything looks great.',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 370.0),
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