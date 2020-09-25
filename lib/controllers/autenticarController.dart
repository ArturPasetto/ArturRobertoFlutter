import 'package:artur_roberto_flutter/models/userModel.dart';
import 'package:artur_roberto_flutter/utils/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AutenticarController{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var dialogError = "".obs;

  //criar objeto usuario com base no usuario enviado pelo firebase
  UserModel _userFromFirebaseUser(User user){
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //stream de usuarios
  Stream<UserModel> get getUser {
    return _firebaseAuth.authStateChanges().map(_userFromFirebaseUser);
  }

  //logar
  Future logar(UserModel usuario, GlobalKey<FormState> formkey) async{
    if(!formkey.currentState.validate()){
      return null;
    }
    formkey.currentState.save();

    try{
      UserCredential authResult = await _firebaseAuth.signInWithEmailAndPassword(email: usuario.getEmail.trim(), password: usuario.getSenha.trim());
      return _userFromFirebaseUser(authResult.user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //deslogar
  Future deslogar() async{
    try{
      return await _firebaseAuth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //registrar anonimamente
/*
  Future registrarAnomimamente() async{
    try{
        UserCredential authResult = await _firebaseAuth.signInAnonymously();
        return _userFromFirebaseUser(authResult.user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  */

  //registrar com email e senha
  Future registrarUsuario(UserModel usuario, GlobalKey<FormState> formkey) async{
    if(!formkey.currentState.validate()){
      return null;
    }
    formkey.currentState.save();

    try{
      UserCredential authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: usuario.getEmail.trim(), password: usuario.getSenha.trim());

      await Banco(uid: authResult.user.uid).atualizarDadosUsuario('aqui é 1', 'aqui é dois', 'aqui é tres', 10);

      return _userFromFirebaseUser(authResult.user);
    }catch(e){
      print(e.toString());
      return null;
    }
}

}