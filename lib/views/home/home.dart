
import 'package:artur_roberto_flutter/controllers/autenticarController.dart';
import 'package:artur_roberto_flutter/models/algoModel.dart';
import 'package:artur_roberto_flutter/utils/database.dart';
import 'package:artur_roberto_flutter/views/autenticacao/loginView.dart';
import 'package:artur_roberto_flutter/styles/modalBottomSheetStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'algoList.dart';

class Home extends StatelessWidget{

  final AutenticarController _autenticarController = AutenticarController();

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<AlgoModel>>.value(
      value: Banco().getAlgo,
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.black26,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon:Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async{
                await _autenticarController.deslogar();
                Get.offAll(LoginView());
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text("Configurações"),
              onPressed: () => mostrarPainelConfiguracao(context),
            )
          ],
        ),
        body: AlgoList(),
      ),
    );
  }

}