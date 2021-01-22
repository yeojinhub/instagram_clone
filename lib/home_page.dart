import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final FirebaseUser user;

  HomePage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Instagram Clone',
          style: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10.0)),
              Text(
                'Instagram에 오신 것을 환영합니다',
                style: TextStyle(fontSize: 20.0),
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              Text('친구들의 사진과 동영상을 보려면 팔로우하세요'),
              Padding(padding: EdgeInsets.all(8.0)),
              SizedBox(
                  width: 250.0,
                  child: Card(
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: 80.0,
                            height: 80.0,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(user.photoUrl),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(10.0)),
                          Text(
                            user.email,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(user.displayName),
                          Padding(padding: EdgeInsets.all(10.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 70.0,
                                height: 70.0,
                                child: Image.network(
                                  'https://cdn.pixabay.com/photo/2019/09/24/06/41/flower-4500426_960_720.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(2.0)),
                              SizedBox(
                                width: 70.0,
                                height: 70.0,
                                child: Image.network(
                                  'https://cdn.pixabay.com/photo/2019/11/03/20/11/portrait-4599559_960_720.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(2.0)),
                              SizedBox(
                                width: 70.0,
                                height: 70.0,
                                child: Image.network(
                                  'https://cdn.pixabay.com/photo/2019/11/03/20/11/portrait-4599553_960_720.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.all(10.0)),
                          RaisedButton(
                            child: Text('로그인'),
                            color: Colors.blueAccent,
                            textColor: Colors.white,
                            onPressed: () {},
                          ),
                          Padding(padding: EdgeInsets.all(10.0)),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
