import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:feed/authentication.dart';

class SignInPage extends StatefulWidget {


  @override
  _MySignInState createState() => _MySignInState();

}

class _MySignInState extends State<SignInPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
   final TextEditingController _textControllerEmail = TextEditingController();
  final TextEditingController _textControllerPassword = TextEditingController();
  var _loading = false;

  @override
  Widget build(BuildContext context) {

    Future<void> signup() async {
    setState(() {
      _loading = true;
    });

    await Provider.of<Auth>(context, listen: false)
        .login(_textControllerEmail.text, _textControllerPassword.text);
    
    setState(() {
      _loading = false;
    });


    Navigator.of(context).pop();
    Navigator.of(context).pushNamed('homepage');
  }

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

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(

        padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
        onPressed: signup,
        child:Text("Sign in.",
          textAlign: TextAlign.center,
          style: style.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 70.0),
                Text('Sign in to your StrathFeed Account.',
                    style: TextStyle(color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(height: 25.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(onTap: (){
                      Navigator.of(context).pushNamed('sign-up');
                    },child: Text('Sign Up \ninstead.', style: TextStyle(color: Colors.blue),)),
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