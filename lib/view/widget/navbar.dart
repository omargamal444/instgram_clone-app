import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instgramclone/model/usermodel.dart';
import 'package:instgramclone/service/auth.dart';
import 'package:instgramclone/view/screen/firsthomepage.dart';
import 'package:instgramclone/view/screen/postimagescreen.dart';
import 'package:instgramclone/view/screen/profile.dart';
import '../screen/instgrampage.dart';
import '../screen/signupscreen.dart';
class Bottomnavbar extends StatefulWidget {


  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}


class _BottomnavbarState extends State<Bottomnavbar> {
  int navbarindex=0;
ImagePicker _picker=ImagePicker();

  @override
  Widget build(BuildContext context) {
   Users _users=Get.arguments[0];
   final usersss=Get.arguments[1];
   final allusers=Get.arguments[2];
    List<Widget>screens=[
      Instgrampage(currentuser: _users,usersss: usersss),
      Profile(_users,users: allusers),
      Postdatascreen(_users)
    ];
    return Scaffold(body:
    screens[navbarindex],
      bottomNavigationBar:BottomNavigationBar(
      currentIndex: navbarindex,
      onTap: (value) {
        setState(() {
          navbarindex=value;
        });
      },
      items:<BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar( radius: 14.0,backgroundImage: AssetImage("image/OIP (1).jpeg")),
          label: 'profile',
        ),
        BottomNavigationBarItem(
        icon: (IconButton(onPressed: (){
         _picker.pickImage(source: ImageSource.camera);
        },
            icon: Icon(Icons.add))),
          label: 'Add',
        ),
      ],
    ),);
  }
}
