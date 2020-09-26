
import 'package:artur_roberto_flutter/controllers/algoController.dart';
import 'package:artur_roberto_flutter/models/algoUserModel.dart';
import 'package:flutter/material.dart';

class AlgoListTile extends StatelessWidget {

  final AlgoUserModel algo;
  AlgoController _algoController = AlgoController();

  AlgoListTile({this.algo});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:EdgeInsets.only(top: 8.0),
      child:Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child:ListTile(
            onTap: () async{
              await this._algoController.excluirDadosUsuario(this.algo.userUID);
            },
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.pink[this.algo.quatro],
            ),
            title: Text(this.algo.um),
            subtitle: Text(this.algo.dois + this.algo.tres),
          )
      ),
    );
  }

}