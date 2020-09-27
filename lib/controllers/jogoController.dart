import 'package:artur_roberto_flutter/models/algoUserModel.dart';
import 'package:artur_roberto_flutter/models/jogoModel.dart';
import 'package:artur_roberto_flutter/utils/banco.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class JogoController{

  Banco _banco = Banco();

  Future adicionarJogo(String nome, int ano, String descricao, List<dynamic> genero, GlobalKey<FormState> formkey) async{
    if(!formkey.currentState.validate()){
      print("aqi");
      return null;
    }
    formkey.currentState.save();


    return await this._banco.jogoCollection.add({
      'nome': nome,
      'ano': ano,
      'descricao': descricao,
      'genero': genero
    }).catchError((erro) => print(erro));

  }

  Future<bool> excluirJogo(String jogoUID) async{

    return await this._banco.jogoCollection.doc(jogoUID)
        .delete()
        .then((value) => true)
        .catchError((erro) => false);

  }

  Future atualizarJogo(String nome, int ano, String descricao, List<dynamic> genero, String jogoUID ) async{
    return await this._banco.jogoCollection.doc(jogoUID).set({
      'nome': nome,
      'ano': ano,
      'descricao': descricao,
      'genero': genero,
    }).catchError((erro) => print(erro));
  }

  Stream<List<JogoModel>> get getListaJogos{
    return this._banco.jogoCollection.snapshots().map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((QueryDocumentSnapshot doc){
        return JogoModel(
            uid: doc.id,
            nome: doc.get('nome'),
            ano: doc.get('ano'),
            descricao: doc.get('descricao'),
            genero: doc.get('genero'),
        );
      }).toList();
    });
  }

  Stream<JogoModel> get getJogo{
    return this._banco.jogoCollection.doc().snapshots().map((DocumentSnapshot documentSnapshot) {
      return JogoModel(
        uid: documentSnapshot.id,
        nome: documentSnapshot.get('nome'),
        ano: documentSnapshot.get('ano'),
        descricao: documentSnapshot.get('descricao'),
        genero: documentSnapshot.get('genero'),
      );
    });
  }

  Future atualizarDadosUsuario(String um, String dois, String tres, int quatro, String userUID) async{

    return await this._banco.algoCollection.doc(Banco.FIREBASE_AUTH.currentUser.uid).set({
      'userUID': userUID,
      'um': um,
      'dois': dois,
      'tres': tres,
      'quatro': quatro
    }).catchError((erro) => print(erro));

  }

  Future<bool> excluirDadosUsuario(String usuarioUID) async{

      return await this._banco.algoCollection.doc(usuarioUID)
        .delete()
        .then((value) => true)
        .catchError((erro) => false);
  }

  //pegar collection algo stream
  Stream<List<AlgoUserModel>> get getAlgo{
    return this._banco.algoCollection.snapshots().map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((QueryDocumentSnapshot doc){
        return AlgoUserModel(
            userUID: doc.get('userUID'),
            um: doc.get('um'),
            dois: doc.get('dois'),
            tres: doc.get('tres'),
            quatro: doc.get('quatro')
        );
      }).toList();
    });
  }

  //pegar dados do usuario com tal UID
  Stream<AlgoUserModel> get getUserAlgo{
    return this._banco.algoCollection.doc(Banco.FIREBASE_AUTH.currentUser.uid).snapshots().map((DocumentSnapshot documentSnapshot) {
      return AlgoUserModel(
        userUID: documentSnapshot.get('userUID'),
        um: documentSnapshot.get('um'),
        dois: documentSnapshot.get('dois'),
        tres: documentSnapshot.get('tres'),
        quatro: documentSnapshot.get('quatro'),
      );
    });
  }


}