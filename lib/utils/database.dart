import 'package:artur_roberto_flutter/models/algoModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Banco{

  final CollectionReference algoCollection = FirebaseFirestore.instance.collection('algo');
  final String uid;
  Banco({this.uid});

  Future atualizarDadosUsuario(String um, String dois, String tres, int quatro) async{

    return await algoCollection.doc(this.uid).set({
      'um': um,
      'dois': dois,
      'tres': tres,
      'quatro': quatro
    });

  }

  //lista de algo do snapchot
  List<AlgoModel> _algoListFromSnapchot(QuerySnapshot querySnapshot){
    return querySnapshot.docs.map((doc){
      return AlgoModel(
          um: doc.get('um'),
          dois: doc.get('dois'),
          tres: doc.get('tres'),
          quatro: doc.get('quatro')
      );
    }).toList();
  }

  //pegar collection algo stream
  Stream<List<AlgoModel>> get getAlgo{
    return algoCollection.snapshots().map(_algoListFromSnapchot);
  }



}