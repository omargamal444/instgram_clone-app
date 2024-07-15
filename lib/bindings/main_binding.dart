import 'package:get/get.dart';
import 'package:instgramclone/controller/profile_controller.dart';
import 'package:instgramclone/controller/user_profile_controller.dart';

class MainBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<Profilecontroller>(
      () => Profilecontroller(),
      fenix: true,
    );
    Get.lazyPut<Userprofilecontroller>(
      () => Userprofilecontroller(),
      fenix: true,
    );
  }
}
