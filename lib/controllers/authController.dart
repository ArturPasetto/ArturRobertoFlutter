import 'package:artur_roberto_flutter/controllers/databaseController.dart';
import 'package:artur_roberto_flutter/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController{

  /*
  _ = private
  final = nunca vai mudar o seu valor
  Future = vai processar por algum tempo e vai devolver alguma coisa no futuro
  metodos async retornam Future
  */

  /*
  FirebaseApp a = await Firebase.initializeApp();
  final FirebaseAuth _auth = FirebaseAuth.instanceFor(app:a);
  */
  var dialogError = "".obs;
  final registrarFormKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void atualizarErro(int valor){
    if(valor == 0) {
      this.dialogError.value = "Email não pode ser vazio";
    }
    else if (valor == 1){
      this.dialogError.value = "Email não é válido";
    }
    else if(valor == 2){
      this.dialogError.value = "Senha não pode ser vazia";
    }
    else if(valor == 3){
      this.dialogError.value = "Senha deve conter no mínimo 6 caracteres";
    }
  }

  //criar Usuario baseado no User do Firebase
  UserModel userFromFirebaseUser(User user){
    //se != de null retorna uma criação de  usuario, caso contrário, retorna null
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //alguma mudança de usuario(logou,deslogou)
  Stream<UserModel> get getUser{
    //usuario passado como parâmetr foi o que veio da Stream
    return _auth.authStateChanges().map(this.userFromFirebaseUser);
  }

  //logar anonimamente
  Future registrarAnonimamente() async {
    if(!registrarFormKey.currentState.validate()){
      return false;
    }
    registrarFormKey.currentState.save();

    //logar com usuario anonimo que o firebase enviou numa Stream
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }

  //cadastrar com email e senha
  Future registrarUsuario(UserModel novoUsuario) async{
    if(!registrarFormKey.currentState.validate()){
      return false;
    }
    registrarFormKey.currentState.save();

    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: novoUsuario.getEmail.trim(), password: novoUsuario.getSenha.trim());
      User user = result.user;

      //await DatabaseController(uid: user.uid).updateDadosUsuario('um', 'dois', 'tres', 1);
      print("\n\n\n AQUI \n\n\n");
      return this.userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}
