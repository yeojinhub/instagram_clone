import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final GoogleSignIn _googleSignIn = GoogleSignIn(); //구글 로그인을 위한 객체
  final FirebaseAuth _mAuth = FirebaseAuth.instance; //파이어베이스 인증 정보

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Instagram Clone',
                style: TextStyle(
                    fontSize: 25.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold)),
            Padding(padding: EdgeInsets.all(30.0)),
            SignInButton(Buttons.Google, onPressed: () {
              _handleSignIn().then((user) {
                print(user);
              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TabPage(user)));
              });
            }),
          ],
        ),
      ),
    );
  }

  Future<FirebaseUser> _handleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = (await _mAuth.signInWithCredential(
        GoogleAuthProvider.getCredential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken)))
        .user;
    print("sign in" + user.displayName);
    return user;
  }
}
