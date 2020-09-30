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
  static UserModel USER_FROM_FIREBASE(User user){
    return user != null ? UserModel(uid: user.uid, nome: user.displayName, email: user.email) : null;
  }

  //pegar usuario da stream de usuarios enviada do firebase
  Stream<UserModel> get getUser {
    return Banco.FIREBASE_AUTH.authStateChanges().map(USER_FROM_FIREBASE);
  }

  Future<UserModel> getDadosUsuario() async{

    print(Banco.FIREBASE_AUTH.currentUser.uid);

    return _banco.usuarioCollection.doc(Banco.FIREBASE_AUTH.currentUser.uid)
        .get()
        .then((value) {
        print(value.get('telefone'));
        print(value.get('aniversario').toDate());
          return UserModel(
            telefone: value.get('telefone'),
            aniversario: value.get('aniversario').toDate()
          );
        }).catchError((erro) {
          print(erro);
        });

  }

  //registrar com email e senha
  Future registrarUsuario(UserModel usuario) async{
    try{
      UserCredential authResult = await Banco.FIREBASE_AUTH.createUserWithEmailAndPassword(email: usuario.email.trim(), password: usuario.getSenha.trim());

      await authResult.user.updateProfile(displayName: usuario.nome);

      await _banco.usuarioCollection.doc(authResult.user.uid).set({
        'telefone': usuario.telefone,
        'aniversario': usuario.aniversario
      });
      await _banco.usuarioCollection.doc(authResult.user.uid).collection('jogos').doc().set({
        'nome': 'Jogo',
        'descricao': 'Descrição',
        'ano': 2000
      });

      return USER_FROM_FIREBASE(authResult.user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<bool> atualizarUsuario(UserModel usuario) async{

    return await _banco.usuarioCollection.doc(Banco.FIREBASE_AUTH.currentUser.uid).update({
      'aniversario': usuario.aniversario,
      'telefone': usuario.telefone
    })
        .then((value) => true)
        .catchError((erro) {
          print(erro);
          return false;
        });
    
  }

}