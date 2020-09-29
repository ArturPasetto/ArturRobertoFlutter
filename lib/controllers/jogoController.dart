import 'package:artur_roberto_flutter/models/jogoModel.dart';
import 'package:artur_roberto_flutter/utils/banco.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class JogoController extends GetxController{

  Banco _banco = Banco();

  Future<bool> adicionarJogo(JogoModel jogo, GlobalKey<FormState> formkey) async{


    return await this._banco.usuarioCollection.doc(Banco.FIREBASE_AUTH.currentUser.uid).collection('jogos').add({
      'nome': jogo.nome,
      'ano': jogo.ano,
      'descricao': jogo.descricao,
    })
        .then((value) => true)
        .catchError((erro) => false);
  }

  Future<bool> excluirJogo(String jogoUID) async{

    return await this._banco.usuarioCollection.doc(Banco.FIREBASE_AUTH.currentUser.uid).collection('jogos').doc(jogoUID)
    .delete()
        .then((value) => true)
        .catchError((erro) {
          print(erro);
          return false;
        });

  }

  Future<bool> atualizarJogo(JogoModel jogo) async{

    return await this._banco.usuarioCollection.doc(Banco.FIREBASE_AUTH.currentUser.uid).collection('jogos').doc(jogo.uid).update({
      'nome': jogo.nome,
      'ano': jogo.ano,
      'descricao': jogo.descricao,
    })
        .then((valor) => true)
        .catchError((erro) {
          print(erro);
          return false;
        });

  }

   Stream<List<JogoModel>> get getListaJogosUser{

    return this._banco.usuarioCollection.doc(Banco.FIREBASE_AUTH.currentUser.uid).collection('jogos')
        .snapshots().map((QuerySnapshot querySnapshot) => querySnapshot.docs.map((QueryDocumentSnapshot doc) {
          return JogoModel(uid: doc.id, nome: doc.get('nome'), ano: doc.get('ano'), descricao: doc.get('descricao'));
    }).toList());
  }

  /*
  Stream<List<JogoModel>> get getListaJogos{
    return this._banco.jogoCollection.snapshots().map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((QueryDocumentSnapshot doc){
        return JogoModel(
            uid: doc.id,
            nome: doc.get('nome'),
            ano: doc.get('ano'),
            descricao: doc.get('descricao'),
        );
      }).toList();
    });
  }

  */

   /*Stream<JogoModel> getJogo(String jogoUID){
    return this._banco.jogoCollection.doc(jogoUID).snapshots().map((DocumentSnapshot documentSnapshot) {
      return JogoModel(
        uid: documentSnapshot.id,
        nome: documentSnapshot.get('nome'),
        ano: documentSnapshot.get('ano'),
        descricao: documentSnapshot.get('descricao'),
      );
    });
  }*/

 /* Future atualizarDadosUsuario(String um, String dois, String tres, int quatro, String userUID) async{

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
*/

}