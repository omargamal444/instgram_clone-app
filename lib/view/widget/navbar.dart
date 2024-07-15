import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instgramclone/model/user_model.dart';
import 'package:instgramclone/view/screen/post_image_screen.dart';
import 'package:instgramclone/view/screen/profile.dart';

import '../screen/instgram_page.dart';

class Bottomnavbar extends StatefulWidget {
  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int navbarindex = 0;
  ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Users _users = Get.arguments[0];
    final usersss = Get.arguments[1];
    final allusers = Get.arguments[2];
    List<Widget> screens = [
      InstgramPage(currentUser: _users, users: usersss),
      Profile(_users, users: allusers),
      Postdatascreen(_users)
    ];
    return Scaffold(
      body: screens[navbarindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navbarindex,
        onTap: (value) {
          setState(() {
            navbarindex = value;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: CircleAvatar(
                radius: 14.0,
                backgroundImage: AssetImage("image/OIP (1).jpeg")),
            label: 'profile',
          ),
          BottomNavigationBarItem(
            icon: (IconButton(
                onPressed: () {
                  _picker.pickImage(source: ImageSource.camera);
                },
                icon: Icon(Icons.add))),
            label: 'Add',
          ),
        ],
      ),
    );
  }
}
