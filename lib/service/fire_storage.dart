import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
class Storagee{
 File? file;
 Future<String>?uri;
 Future<String> storeimage({@required File? file,
 @required String? imagename,@required String? refname})async{
 var storag = FirebaseStorage.instance.ref(refname).child("$imagename");
  UploadTask uploadTask= storag.putFile(file!);
  uploadTask.then((res) async{
Future<String> url= res.ref.getDownloadURL();
print(url);
print("///////////////////////////////////////////////////////////");
  });
   return uri!;
 }
}
