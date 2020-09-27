import 'package:artur_roberto_flutter/models/algoUserModel.dart';
import 'package:artur_roberto_flutter/models/jogoModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'jogoListTile.dart';



class JogoList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final listaJogo = Provider.of<List<JogoModel>>(context) ?? [];

    /*listaJogo.forEach((jogo) {
        print(jogo.nome);
        print(jogo.ano);
        print(jogo.descricao);
        print(jogo.uid);
        print(jogo.genero);
      });
*/

    return ListView.builder(
      itemCount: listaJogo.length,
      itemBuilder: (context, index){
        return JogoListTile(jogo: listaJogo.elementAt(index));
      },
    );
  }

}