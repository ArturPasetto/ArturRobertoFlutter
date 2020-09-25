import 'package:artur_roberto_flutter/controllers/authController.dart';
import 'file:///E:/Users/ArturW7/AndroidStudioProjects/artur_roberto_flutter/lib/controllers/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return StreamProvider<UserModel>.value(
       value: AuthController().getUser,
       child: GetMaterialApp(
           home: Wrapper()
       ));
  }
}

