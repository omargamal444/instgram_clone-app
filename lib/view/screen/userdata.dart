import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instgramclone/const.dart';
import 'package:instgramclone/view/screen/login_screen.dart';
import 'package:path/path.dart';

import '../../service/fire_storage.dart';

class Userdata extends StatelessWidget {
  Storagee _storage = Storagee();
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController secondnamecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController careercontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final emaill = Get.arguments;
    XFile? imagee;
    String? imageename;
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter your data"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          texetfield("First name", firstnamecontroller),
          texetfield("Second name", secondnamecontroller),
          texetfield("age", agecontroller),
          texetfield("career", careercontroller),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ElevatedButton(
                onPressed: () async {
                  ImagePicker _picker = ImagePicker();
                  XFile? image =
                      await _picker.pickImage(source: ImageSource.camera);
                  imagee = image;
                  imageename = basename(image!.path);
                  //data base function
                },
                child: Text("اضغط لاختيار صورة للملف الشخصى")),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ElevatedButton(
                  onPressed: () async {
                    await _storage.storeimage(
                        file: File(imagee!.path),
                        imagename: imageename!,
                        refname: Consts.profileimages);
                    print(
                        "***************************************************************");
                    await addUser(
                        email: emaill,
                        age: agecontroller.text,
                        firstname: firstnamecontroller.text,
                        secondname: secondnamecontroller.text,
                        career: careercontroller.text,
                        imageuri: await _storage.storeimage(
                            file: File(imagee!.path),
                            imagename: imageename!,
                            refname: Consts.profileimages));
                  },
                  child: Text("Confirm data")))
        ]),
      ),
    );
  }

  Widget texetfield(String text, TextEditingController _controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: TextField(
        decoration: InputDecoration(hintText: text),
        controller: _controller,
      ),
    );
  }
}

Future<void> addUser(
    {String? firstname,
    String? secondname,
    String? age,
    String? id,
    String? email,
    String? career,
    String? imageuri}) async {
  final docref = await FirebaseFirestore.instance.collection('User').doc();

  Future<String> getid() async {
    DocumentSnapshot docSnap = await docref.get();
    var doc_id2 = docSnap.reference.id;
    return (doc_id2);
  }

  docref.set({
    "firstname": firstname,
    "secondname": secondname,
    "age": age,
    "id": await getid(),
    "email": email,
    "career": career,
    "imageurl": imageuri
  });

  Get.to(LoginScreen(), arguments: await getid());
}
