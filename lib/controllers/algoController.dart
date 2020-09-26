
import 'package:artur_roberto_flutter/models/algoUserModel.dart';
import 'package:artur_roberto_flutter/utils/banco.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlgoController{

  final Banco banco = Banco();

  Future atualizarDadosUsuario(String um, String dois, String tres, int quatro, String userUID) async{

    return await banco.algoCollection.doc(Banco.FIREBASE_AUTH.currentUser.uid).set({
      'userUID': userUID,
      'um': um,
      'dois': dois,
      'tres': tres,
      'quatro': quatro
    });

  }

  Future excluirDadosUsuario(String usuarioUID) async{

    return await banco.algoCollection.doc(usuarioUID)
        .delete()
        .then((value) => print("ok"))
        .catchError((erro) => print(erro));

  }

  //lista de algo do snapchot
  List<AlgoUserModel> _algoListFromSnapchot(QuerySnapshot querySnapshot){
    return querySnapshot.docs.map((doc){
      return AlgoUserModel(
          userUID: doc.get('userUID'),
          um: doc.get('um'),
          dois: doc.get('dois'),
          tres: doc.get('tres'),
          quatro: doc.get('quatro')
      );
    }).toList();
  }

  //pegar collection algo stream
  Stream<List<AlgoUserModel>> get getAlgo{
    return banco.algoCollection.snapshots().map(_algoListFromSnapchot);
  }

  AlgoUserModel _userAlgoFromSnapshot(DocumentSnapshot documentSnapshot){
    return AlgoUserModel(
      userUID: documentSnapshot.get('userUID'),
      um: documentSnapshot.get('um'),
      dois: documentSnapshot.get('dois'),
      tres: documentSnapshot.get('tres'),
      quatro: documentSnapshot.get('quatro'),
    );
  }

  //pegar dados do usuario com tal UID
  Stream<AlgoUserModel> get getUserAlgo{
    return banco.algoCollection.doc(Banco.FIREBASE_AUTH.currentUser.uid).snapshots().map(this._userAlgoFromSnapshot);
  }



}