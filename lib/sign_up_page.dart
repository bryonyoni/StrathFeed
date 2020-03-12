import 'package:feed/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title, this.loginCallback}) : super(key: key);
  final String title;

  // final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var _loading = false;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);

  final TextEditingController _textControllerEmail = TextEditingController();
  final TextEditingController _textControllerPassword = TextEditingController();

  Future<void> signup() async {
    setState(() {
      _loading = true;
    });

    await Provider.of<Auth>(context, listen: false)
        .signup(_textControllerEmail.text, _textControllerPassword.text);
    
    setState(() {
      _loading = false;
    });   
   
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed('homepage');
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      style: style,
      controller: _textControllerEmail,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
      ),
    );
    final passwordField = TextField(
      obscureText: true,
      controller: _textControllerPassword,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
      ),
    );
    final confirmPasswordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Confirm Password",
      ),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
        onPressed: signup,
        child: Text("Sign Up.",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 70.0),
                Text(
                  'Sign up for a StrathFeed Account.',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 25.0,
                ),
                confirmPasswordField,
                SizedBox(
                  height: 35.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('sign-in');
                        },
                        child: Text(
                          'Sign In \ninstead.',
                          style: TextStyle(color: Colors.blue),
                        )),
                    loginButton,
                  ],
                ),
                _loading
                    ? Align(
                        alignment: Alignment.center,
                        child: Container(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator()))
                    : SizedBox(
                        height: 10,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
