import 'dart:convert';

import 'package:feed/feedback.dart';
import 'package:feed/feedback_item.dart';
import 'package:feed/location.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'authentication.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<HomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
  bool isInit = false;
  List<myFeedback> myLoadedFeedbacks = [];
  bool isLoading = false;

  Future<String> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final extractedUserData = json.decode(prefs.getString('userData')) as Map<String, Object>;
    final user = extractedUserData['userId'];
    print(user);

    return user;
  }

  Future<void> fetchAndSetFeedbackProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final extractedUserData = json.decode(prefs.getString('userData')) as Map<String, Object>;
    final me = extractedUserData['userId'];

    String url = 'https://strathfeed.firebaseio.com/feedback.json';

    try{
      final response = await http.get(url);
      final loadedData = json.decode(response.body) as Map<String,dynamic>;
      print(loadedData.toString());
      List<myFeedback> loadedFeedbacks = [];

      if(loadedData != null && loadedData.isNotEmpty){
        loadedData.forEach((sentiment, feedList){
          print("sentiment: "+sentiment);
//          print("list: "+feedList.toString());
          feedList.forEach((feedId, feedData){
            String explanation = feedData['explanation'];
            String user = feedData['user'];
            String feedbackId = feedId;
            String status = "Ok";
            if(feedData['status']!=null) status = feedData['status'];
            DateTime time = null;
            if(feedData['time']!=null){
              time = DateTime.parse(feedData['time']);
            }
            final location = json.decode(feedData['loc']) as Map<String,dynamic>;
            String locationName = "";
            String locationAreaClass = "";
            String email = "";
            location.forEach((locItemName,locItemData){
              if(locItemName == "name"){
                locationName = locItemData;
              }else if(locItemName =="areaClass"){
                locationAreaClass = locItemData;
              }else if(locItemName == "email"){
                email = locItemData;
              }
            });
            Location theLocation = new Location(locationName, locationAreaClass, email);

            myFeedback mf = myFeedback();
            mf.location = theLocation;
            mf.user = user;
            mf.pushId = feedbackId;
            mf.status = status;
            mf.description = explanation;
            mf.sentiment = sentiment;
            if(time!=null)mf.timeOfSending = time;

            if(mf.user == me) loadedFeedbacks.add(mf);

          });
        });
      }
      
      setState(() {
        myLoadedFeedbacks = loadedFeedbacks.reversed.toList();
        isLoading = false;  
      });
    }catch(error){
      print("Error: "+error.toString());
    }
  } 

  @override
  void didChangeDependencies(){
    if(!isInit){
      isLoading = true;
      fetchAndSetFeedbackProducts();
    }
    // isInit = true;
    super.didChangeDependencies();
  }

  List<Widget> getAllFeedbackWidgets(){
      List<Widget> theLoadedWidgets = List();
      if(myLoadedFeedbacks.isEmpty){
        theLoadedWidgets.add(Center(
          child: Container(
            child: Text("Your passed feedback will appear here."),
          ),
        ));
      }else for(myFeedback item in myLoadedFeedbacks){
        theLoadedWidgets.add(
            InkWell(onTap: () async {
              showDialogForFoundLocation(item);
            },child: FeedbackItem(feedbackData: item,))
        );
      }
      return theLoadedWidgets;
    }

  Widget dialogView(myFeedback item){
    var color = Colors.blue;
    if(item.sentiment =='negative'){
      color = Colors.red;
    }
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Text(item.location.name,
          style: style.copyWith(
              color: Colors.black45,
              fontSize: 12)
          ),
          SizedBox(height: 10.0),
          Text(item.description,
              style: style.copyWith(
                color: color,
                fontSize: 11,)
          ),
          SizedBox(height: 10.0),
          Text(item.status,
              style: style.copyWith(
                color: Colors.lightGreen,
                fontSize: 11,
              )
          ),
        ],
      ),
    );

  }

  Future<void> showDialogForFoundLocation(myFeedback item) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(DateFormat.yMMMMEEEEd('en_US').format(item.timeOfSending)),
          content: dialogView(item),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
                InkWell(onTap: () async {
                  //  await Provider.of<Auth>(context, listen: false).logout();
                  Navigator.of(context).pushNamed('feedback-sent-page');
                },child: Image(image: AssetImage('assets/chat_icon.png'),
                    height: 0,
                    width: 0,
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

            Container(
              height: 210,
              child: isLoading? Center(
                                child: CircularProgressIndicator(),
                            ) : ListView(
                                    children: getAllFeedbackWidgets()
                                ),
            ),
          ],
        ),
      ),
    );
  }
}