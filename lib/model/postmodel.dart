import 'package:flutter/cupertino.dart';
import 'package:instgramclone/model/commentmodel.dart';
class Post{
  String? postimageurl;
 List<dynamic>?comments;
  Post({@required this.postimageurl,@required this.comments});
}