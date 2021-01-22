import 'package:flutter/material.dart';
import 'package:instagram_clone/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/tab_page.dart';

import 'loading_page.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _handleCurrentScreen();
  }

  Widget _handleCurrentScreen() {
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingPage();
          } else {
            if (snapshot.hasData) {
              return TabPage(snapshot.data);
            } else {
              return LoginPage();
            }
          }
        }
    );
  }
}
