import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseController  {


  final String uid;
  DatabaseController({this.uid});

  final CollectionReference algoCollection = FirebaseFirestore.instance.collection("algo");

  Future updateDadosUsuario(String um, String dois, String tres, int quatro) async{

    //se não houver alguma coleção para o usuário de tal UID, o Firebase criará isso automaticamente
    return await algoCollection.doc(this.uid).set({
      'um': um,
      'dois': dois,
      'tres': tres,
      'quatro': quatro
    });
  }


}