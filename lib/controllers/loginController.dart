import 'package:artur_roberto_flutter/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'authController.dart';
import 'databaseController.dart';

class LoginController extends GetxController{

  var dialogError = "".obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final loginFormKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  //logar com email e senha
  Future logar(UserModel usuario) async{
    if(!loginFormKey.currentState.validate()){
      return false;
    }
    loginFormKey.currentState.save();

    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: usuario.getEmail.trim(), password: usuario.getSenha.trim());
      User user = result.user;

      return _authController.userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //deslogar
  Future deslogar() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}