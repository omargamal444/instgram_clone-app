import 'package:flutter/material.dart';
import 'package:instgramclone/Bindings/controllers.dart';
import 'package:instgramclone/controller/profilecontroller.dart';
import 'package:instgramclone/firebase_options.dart';
import 'package:instgramclone/view/screen/firsthomepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
  );
  await Hive.initFlutter();
  MainBinding mainBinding = MainBinding();
  await mainBinding.dependencies();
  runApp(const MyApp()
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(home: Homepage());
  }
}
