import 'package:artur_roberto_flutter/controllers/algoController.dart';
import 'package:artur_roberto_flutter/controllers/loginController.dart';
import 'package:artur_roberto_flutter/models/algoUserModel.dart';
import 'package:artur_roberto_flutter/views/autenticacao/loginView.dart';
import 'package:artur_roberto_flutter/views/home/settingsFormView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'algoList.dart';

class Home extends StatelessWidget{

  LoginController _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<AlgoUserModel>>.value(
      value: AlgoController().getAlgo,
      child: Scaffold(
        backgroundColor: Colors.grey,
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
            FlatButton.icon(
              icon: Icon(Icons.settings, color: Colors.white,),
              label: Text("Configurações", style: TextStyle(color: Colors.white),),
              onPressed: () => Get.to(SettingsFormView()),
            )
          ],
        ),
        body: AlgoList(),
      ),
    );
  }

}