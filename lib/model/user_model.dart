import 'package:flutter/cupertino.dart';
class Users{
  String?firstname;
  String?secondname;
  String?id;
  String?email;
  String?age;
  String?career;
  String?imageurl;
  String?postnum;
  List?posts;
  List?followers;

  Users({this.firstname, this.secondname, this.id, this.email, this.age,@required this.postnum,
    this.career,@required this.imageurl,this.posts,this.followers});
}
