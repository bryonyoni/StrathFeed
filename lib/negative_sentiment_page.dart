import 'dart:collection';
import 'dart:convert';

import 'package:feed/feedback.dart';
import 'package:feed/feedback_item.dart';
import 'package:feed/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'feedback_sent_page.dart';
import 'sentiment_expanation_item.dart';

class NegativeSentimentPage extends StatefulWidget {
  NegativeSentimentPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyNegativeSentimentPageState createState() => _MyNegativeSentimentPageState();

}

class _MyNegativeSentimentPageState extends State<NegativeSentimentPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
  List<sugestedItem> mySuggestedItems = myFeedback.loadSomeSuggestedItems(Location.location.areaClass);
  final TextEditingController _textController =  TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final explanationField = TextField(
      obscureText: false,
      style: style,
      controller: _textController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hoverColor: Colors.blue,
          hintText: "Say Something...",
          hintStyle: TextStyle(
              color: Colors.blue
          )
      ),
    );

    List encodeToJson(List<sugestedItem>list){
      List jsonList = List();
      list.map((item)=>
          jsonList.add(item.toJson())
      ).toList();
      return jsonList;
    }

    void sendToFirebase(){
      print('sending to firebase');
      String explanation = _textController.text;
      List<sugestedItem> mySelectedSuggestedItems = List();
      for(sugestedItem item in mySuggestedItems){
        if(item.isSelected){
          mySelectedSuggestedItems.add(item);
        }
      }
      String loc = jsonEncode(Location.location).toString();

      String selectedSuggestions = jsonEncode(mySelectedSuggestedItems).toString();
      print(selectedSuggestions);
      const url = 'https://strathfeed.firebaseio.com/feedback/negative.json';
      http.post(url,body: json.encode({
        'explanation': explanation,
        'selectedItems': selectedSuggestions,
        'loc': loc,
        'time': DateTime.now().toIso8601String(),
      }),).then((response){
         Navigator.pushAndRemoveUntil(
            context, 
            MaterialPageRoute(
              builder: (context) => FeedbackSentPage()
            ), 
            ModalRoute.withName("/HomePage")
         );
          // Navigator.of(context).pushNamed('feedback-sent-page');
      }).catchError((error){
        setState(() {
          isLoading = false;
        });
        print(error.toString());
        
      });
      setState(() {
        isLoading = true;
      });
    }

    final continueButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
        onPressed: () {},
        child:InkWell(onTap: (){
          sendToFirebase();
        },child: Text("Submit.",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold))),
      ),
    );

    List<Widget> getAllOtherOptions(){
      List<Widget> theLoadedWidgets = List();
      for(sugestedItem item in mySuggestedItems){
        theLoadedWidgets.add(
            InkWell(onTap: (){
              setState(() {
                print('item selected: '+item.text);
                int pos = mySuggestedItems.indexOf(item);
                mySuggestedItems.remove(item);
                mySuggestedItems.insert(pos, sugestedItem(text: item.text, isSelected: !item.isSelected));
              });
            },child:SentimentExplanationItem(item: item,))
        );
      }
      return theLoadedWidgets;
    }

    return Scaffold(
      body: isLoading? Center(
        child: CircularProgressIndicator(),
      ): Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(40, 70, 40, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('What Seems To Be The Problem?',
                        style: TextStyle(color: Colors.blue,
                            fontSize: 23,
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
                    SizedBox(height: 50.0),
                    Text('Alternatively, you can pick some of these options.',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        )
                    ),
                    Container(
                      height: 200,
                      child: ListView(
                        children: getAllOtherOptions()
                      ),
                    ),
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