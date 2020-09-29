import 'package:artur_roberto_flutter/models/userModel.dart';
import 'package:artur_roberto_flutter/utils/banco.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController{

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

  //JogoController _jogoController = JogoController();
  Banco _banco = Banco();

  //criar objeto usuario com base no usuario enviado pela stream do firebase
  UserModel userFromFirebaseUser(User user){
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //pegar usuario da stream de usuarios enviada do firebase
  Stream<UserModel> get getUser {
    return Banco.FIREBASE_AUTH.authStateChanges().map(this.userFromFirebaseUser);
  }

  //registrar com email e senha
  Future registrarUsuario(UserModel usuario) async{
    try{
      UserCredential authResult = await Banco.FIREBASE_AUTH.createUserWithEmailAndPassword(email: usuario.getEmail.trim(), password: usuario.getSenha.trim());

      await _banco.usuarioCollection.doc(authResult.user.uid).collection('jogos').doc().set({
        'nome': 'Jogo',
        'descricao': 'Descrição',
        'ano': 2000
      });

      return this.userFromFirebaseUser(authResult.user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}