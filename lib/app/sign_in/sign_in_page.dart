import 'package:flutter/material.dart';
import 'package:timetracker/app/sign_in/sign_in_button.dart';
import 'package:timetracker/app/sign_in/social_sign_in_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInPage extends StatelessWidget {
  Future<void>  _signInAnonymosly() async {
    try{
      final authResult = await FirebaseAuth.instance.signInAnonymously();
      print('${authResult.user.uid}');

    }catch (e){
      print(e);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Center(
          child: Text("Time Tracker"),
        ),
      ),
      body: _buildfContext(),
      backgroundColor: Colors.grey[200],
    );
  }

  Container _buildfContext() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Text(
              'Sign In',
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 48.0),
          SocialSignInButton(
            text: "Sign In with Google",
            color: Colors.white,
            textColor: Colors.black,
            assentName: "images/google-logo.png",
            onPressed: () {},
          ),
          SizedBox(
            height: 8.0,
          ),

          SocialSignInButton(
            text: "Sign In with FaceBook",
            color: Color(0xff334d92),
            textColor: Colors.white,
            assentName: "images/facebook-logo.png",
            onPressed: () {},
          ),
          SizedBox(height: 8.0),
          SignINButton(
            text: "Sign in with Gmail",
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: () {},
          ),
          SizedBox(
            height: 8.0,
          ),
          Center(
            child: Text(
              "or",
              style: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
          ),
          SizedBox(height: 8.0),
          SignINButton(
            text: "Go anonymous",
            textColor: Colors.black,
            color: Colors.lime[300],
            onPressed: _signInAnonymosly,
          ),
        ],
      ),
    );
  }
}
