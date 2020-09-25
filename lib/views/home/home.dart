import 'package:artur_roberto_flutter/controllers/authController.dart';
import 'package:artur_roberto_flutter/controllers/loginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Home extends StatelessWidget{

  final LoginController _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                await _loginController.deslogar();
            },
          )
        ],
      ),
    );
  }

}