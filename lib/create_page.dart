import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePage extends StatefulWidget {
  final FirebaseUser user;
  CreatePage(this.user);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final textEditingController = TextEditingController();

  File _image;
  final _picker = ImagePicker();

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            final ref = FirebaseStorage.instance
                .ref()
                .child('post')
                .child('${DateTime.now().millisecondsSinceEpoch}.png');
            final task = ref.putFile(
              _image, StorageMetadata(contentType: 'image/png')
            );

            task.onComplete.then((value) {
              var downloadUrl = value.ref.getDownloadURL();

              downloadUrl.then((url) {
                var doc = Firestore.instance.collection("post").document();
                doc.setData({
                  'id' : doc.documentID,
                  'photoUrl' : url.toString(),
                  'contents' : textEditingController.text,
                  'email' : widget.user.email,
                  'displayName' : widget.user.displayName,
                  'userPhotoUrl' : widget.user.photoUrl
                }).then((onValue) {
                  Navigator.pop(context);
                });
              });
            });
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        _image == null ? Text('No Image') : Image.file(_image),
        TextField(
          controller: textEditingController,
          decoration: InputDecoration(hintText: '내용을 입력하세요.'),
        )
      ],
    ));
  }

  Future _getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No Image selected.');
      }
    });
  }
}
