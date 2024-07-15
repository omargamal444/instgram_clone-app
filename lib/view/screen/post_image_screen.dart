import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instgramclone/const.dart';
import 'package:instgramclone/service/auth.dart';
import 'package:instgramclone/service/fire_storage.dart';
import 'package:path/path.dart';

import '../../model/user_model.dart';

class Postdatascreen extends StatelessWidget {
  ImagePicker _picker = ImagePicker();
  Storagee _storagee = Storagee();
  Users _users = Users();
  Postdatascreen(this._users);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              Auth _auth = Auth();
              _users = await _auth.getuserData(email: _users.email);
              final image = await _picker.pickImage(source: ImageSource.camera);
              final imagename = basename(image!.path);
              //await _storagee.storeimage(file: File(image.path), imagename: imagename,
              //  refname: Consts.postimages);
              print("111111111111111111111111111111111111111111111111111");
              await addPostsToUser(
                  docpath: _users.id,
                  postimageurl: await _storagee.storeimage(
                      file: File(image.path),
                      imagename: imagename,
                      refname: Consts.postimages));
              print(
                  "*********************************************************");
            },
            child: Text("Post image from camera"),
          ),
          ElevatedButton(
            onPressed: () async {
              final image =
                  await _picker.pickImage(source: ImageSource.gallery);
            },
            child: Text("Post image from Gallery"),
          ),
        ],
      )),
    );
  }
}

Future<void> addDatatouser(
    {@required String? docpath, @required String? postimageurl}) async {
  DocumentReference ref =
      FirebaseFirestore.instance.collection(Consts.users).doc(docpath);
  FirebaseFirestore.instance.runTransaction((transaction) async {
    await transaction.update(ref, {
      "Post": [
        {
          "postimageurl": postimageurl,
          "comments": ["ffffffffff", "uuuuuuu"]
        },
      ]
    });
  });
}

Future<void> addPostsToUser(
    {@required String? docpath, @required String? postimageurl}) async {
  print("77777777777777777777777777777777777777777777");
  DocumentReference ref =
      FirebaseFirestore.instance.collection(Consts.users).doc(docpath);
  print("55555555555555555555555555555555555555555555555555555555555");
  await ref.collection("Posts").add({"postimageurl": postimageurl});
  print("66666666666666666666666666666666666666666666666");
}
