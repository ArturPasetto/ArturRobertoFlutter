import 'package:artur_roberto_flutter/views/autenticacao/loginView.dart';
import 'package:artur_roberto_flutter/views/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'controllers/autenticarController.dart';
import 'models/userModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      value: AutenticarController().getUser,
      child: GetMaterialApp(
          home:LoginView()
      ),
    );
  }
}