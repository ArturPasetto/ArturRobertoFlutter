import 'package:artur_roberto_flutter/controllers/jogoController.dart';
import 'package:artur_roberto_flutter/controllers/loginController.dart';
import 'package:artur_roberto_flutter/models/algoUserModel.dart';
import 'package:artur_roberto_flutter/models/jogoModel.dart';
import 'package:artur_roberto_flutter/views/autenticacao/loginView.dart';
import 'package:artur_roberto_flutter/views/home/settingsFormView.dart';
import 'package:artur_roberto_flutter/views/jogo/addJogoView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'jogoList.dart';

class Home extends StatelessWidget{

  LoginController _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<JogoModel>>.value(
      value: JogoController().getListaJogos,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Home', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.black26,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon:Icon(Icons.person,  color: Colors.white,),
              label: Text('Logout', style: TextStyle(color: Colors.white),),
              onPressed: () async{
                await _loginController.deslogar();
                Get.offAll(LoginView());
              },
            ),
            /*FlatButton.icon(
              icon: Icon(Icons.settings, color: Colors.white,),
              label: Text("Configurações", style: TextStyle(color: Colors.white),),
              onPressed: () => Get.to(SettingsFormView()),
            )*/
          ],
        ),
        body: JogoList(),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.to(AdicionarJogoView());
          },
          backgroundColor: Colors.pinkAccent,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

}








