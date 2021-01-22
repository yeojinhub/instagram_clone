import 'package:flutter/material.dart';

class PostPage extends StatelessWidget {
  final dynamic document;

  PostPage(this.document);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시물'),
      ),
      body: _buildbody(),
    );
  }

  Widget _buildbody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(document['userPhotoUrl']),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        document['email'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(document['displayName'])
                    ],
                  ),
                )
              ],
            ),
          ),
          Image.network(document['photoUrl']),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(document['contents']),
          ),
        ],
      ),
    );
  }
}
