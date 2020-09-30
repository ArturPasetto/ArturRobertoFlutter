import 'package:artur_roberto_flutter/views/autenticacao/loginView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'controllers/userController.dart';
import 'models/userModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'artur-roberto-flutter',
      options: FirebaseOptions(
          apiKey: "AIzaSyCCgbt2FTofwK2kZTuIA4UBp9M9Lnzni6I",
          authDomain: "artur-roberto-flutter.firebaseapp.com",
          databaseURL: "https://artur-roberto-flutter.firebaseio.com",
          projectId: "artur-roberto-flutter",
          storageBucket: "artur-roberto-flutter.appspot.com",
          messagingSenderId: "639788714453",
          appId: "1:639788714453:web:4486cad272f7ef6dd5555c",
          measurementId: "G-N23CXY07MT"
      ));
  //final await Future<FirebaseApp> _initialization = Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      value: UserController().getUser,
      child: GetMaterialApp(
        home:LoginView(),
      ),
    );
  }
}