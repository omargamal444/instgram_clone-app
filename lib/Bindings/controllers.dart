import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:instgramclone/controller/profilecontroller.dart';
import 'package:instgramclone/controller/userprofilecontroller.dart';
import 'package:instgramclone/model/usermodel.dart';

class MainBinding implements Bindings {
  @override
  Future<void> dependencies() async{
    Get.lazyPut<Profilecontroller>(() => Profilecontroller(), fenix: true);
    Get.lazyPut<Userprofilecontroller>(()=>Userprofilecontroller(),fenix: true);
  }
}