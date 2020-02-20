import 'package:feed/describe_location_page.dart';
import 'package:feed/feed_chat_page.dart';
import 'package:feed/feedback_sent_page.dart';
import 'package:feed/home_page.dart';
import 'package:feed/negative_sentiment_page.dart';
import 'package:feed/positive_sentiment_page.dart';
import 'package:feed/qr_scan_page.dart';
import 'package:feed/scanner_page.dart';
import 'package:feed/sentiment_page.dart';
import 'package:feed/sign_up_page.dart';
import 'package:feed/sign_in_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Strath Feed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SignUpPage(title: 'Sign Up'),
      routes: {
        'sign-in':(ctx)=>SignInPage(),
        'sign-up':(ctx)=>SignUpPage(),
        'homepage':(ctx)=>HomePage(),
        'qr-scan-page':(ctx)=>QRScanPage(),
        'sentiment-page':(ctx)=>SentimentPage(),
        'scan-page':(ctx)=>ScannerPage(),
        'describe-location-page':(ctx)=>DescribeLocationPage(),
        'positive-sentiment-page':(ctx)=>PositiveSentimentPage(),
        'positive-sentiment-page':(ctx)=>PositiveSentimentPage(),
        'negative-sentiment-page':(ctx)=>NegativeSentimentPage(),
        'feedback-sent-page':(ctx)=>FeedbackSentPage(),
        'feed-chat-page':(ctx)=>FeedChatPage(),
      },
    );
  }


}



