import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instgramclone/view/screen/loginscreen.dart';
import 'package:instgramclone/view/screen/signupscreen.dart';
class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
      SingleChildScrollView(
        child: SizedBox(width: 750,child:  Column(
          children: [
           ElevatedButton(onPressed: (){}, child: Text("press")),
          const Padding(
            padding: EdgeInsets.only(top: 200,bottom: 150),
            child: Text("Welcome to inst-gram clone",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          ),
            Image.asset("image/OIP (2).jpeg"),
            Row(
              children: [
            const  Padding(
                padding:  EdgeInsets.only(left: 70),
                child: Text("Do you want to"),
              ),
                TextButton(onPressed: (){
                  Get.to(Signupscreen());
                }, child: const Text("Sign up",style: TextStyle(fontSize: 20),)),
               const Text("or"),
                TextButton(onPressed:(){
                  Get.to(Loginscreen());
                } , child: const Text("log in",style: TextStyle(fontSize: 20),)),
                  ],
            ),
        ],),),
      ),);
  }
}



