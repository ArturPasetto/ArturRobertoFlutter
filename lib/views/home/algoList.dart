
import 'package:artur_roberto_flutter/models/algoModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'algoListTile.dart';

class AlgoList extends StatefulWidget{
  @override
  _AlgoListState createState() => _AlgoListState();
}




class _AlgoListState extends State<AlgoList>{
  @override
  Widget build(BuildContext context) {

    final listaAlgo = Provider.of<List<AlgoModel>>(context);

    /*listaAlgo.forEach((algo) {
      print(algo.um);
      print(algo.dois);
      print(algo.tres);
      print(algo.quatro);
    });
     */

    return ListView.builder(
      itemCount: listaAlgo.length,
      itemBuilder: (context, index){
        return AlgoListTile(algo: listaAlgo.elementAt(index));
      },
    );
  }

}