import 'package:artur_roberto_flutter/models/algoModel.dart';
import 'package:flutter/material.dart';

class AlgoListTile extends StatelessWidget {

  final AlgoModel algo;

  AlgoListTile({this.algo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.only(top: 8.0),
      child:Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child:ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.pinkAccent,
            ),
            title: Text(algo.um),
            subtitle: Text(algo.dois + algo.tres),
          )
      ),
    );
  }

}