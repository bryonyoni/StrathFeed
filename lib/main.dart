import 'package:feed/authentication.dart';
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
import 'package:feed/splashscreen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => Auth())],
      child: Consumer<Auth>(
        builder: (con, auth, _) => MaterialApp(
          title: 'Strath Feed',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          // home: SignUpPage(title: 'Sign Up'),
          home: auth.isAuth
              ? HomePage()
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (ctx, authResultsnapshot) =>
                      authResultsnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : SignInPage()),
          routes: {
            'sign-in': (ctx) => SignInPage(),
            'sign-up': (ctx) => SignUpPage(),
            'homepage': (ctx) => HomePage(),
            'qr-scan-page': (ctx) => QRScanPage(),
            'sentiment-page': (ctx) => SentimentPage(),
            'scan-page': (ctx) => ScannerPage(),
            'describe-location-page': (ctx) => DescribeLocationPage(),
            'positive-sentiment-page': (ctx) => PositiveSentimentPage(),
            'negative-sentiment-page': (ctx) => NegativeSentimentPage(),
            'feedback-sent-page': (ctx) => FeedbackSentPage(),
            'feed-chat-page': (ctx) => FeedChatPage(),
          },
        ),
      ),
    );
  }
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}
