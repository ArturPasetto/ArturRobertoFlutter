import 'package:artur_roberto_flutter/controllers/userController.dart';
import 'package:artur_roberto_flutter/models/userModel.dart';
import 'package:artur_roberto_flutter/utils/banco.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginController {

  UserController _userController = UserController();

  //logar
  Future logar(UserModel usuario, GlobalKey<FormState> formkey) async{
    if(!formkey.currentState.validate()){
      return null;
    }
    formkey.currentState.save();

    try{
      UserCredential authResult = await Banco.FIREBASE_AUTH.signInWithEmailAndPassword(email: usuario.getEmail.trim(), password: usuario.getSenha.trim());
      return this._userController.userFromFirebaseUser(authResult.user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //deslogar
  Future deslogar() async{
    try{
      return await Banco.FIREBASE_AUTH.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }




}