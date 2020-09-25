import 'package:artur_roberto_flutter/controllers/authController.dart';
import 'package:flutter/material.dart';
import 'package:artur_roberto_flutter/models/userModel.dart';
import 'package:artur_roberto_flutter/styles/formStyle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class Registrar extends GetView<AuthController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar:AppBar(
            backgroundColor: Colors.blue,
            elevation: 0.0,
            title:Text("Registrar"),
            actions: <Widget>[
              FlatButton.icon(
                icon:Icon(Icons.person, color: Colors.white),
                label: Text('Login', style: TextStyle(color:Colors.white)),
                onPressed:() => Get.back(),
          )
          ],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal:25.0),
            child: RegistrarForm()
        )
    );
  }
  
}


class RegistrarForm extends StatelessWidget{

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  AuthController _authController = AuthController();
  UserModel _user = UserModel();

  @override Widget build(BuildContext context) {

    return Form(
      key: _authController.registrarFormKey,
      child:Column(
          children:<Widget>[
            SizedBox(height:20),
            TextFormField(
              decoration: textFormFieldDecoration.copyWith(labelText: 'Email'),
              onSaved: (value) =>  _user.setEmail = value,
              validator: (value){
                if(value.isEmpty) _authController.atualizarErro(0);
                else if (!value.contains('@')) _authController.atualizarErro(1);
                return null;
              },
            ),
            SizedBox(height:20),
            TextFormField(
                obscureText: true,
                decoration:textFormFieldDecoration.copyWith(labelText: 'Senha'),
                onSaved: (value) => _user.setSenha = value ,
                validator: (value){
                  if(value.isEmpty) _authController.atualizarErro(2);
                  else if (value.length < 6) _authController.atualizarErro(3);
                  return null;
                }
            ),
            SizedBox(height:20),
            RaisedButton(
              color: Colors.blue,
              child: Text('Registrar', style: TextStyle(color: Colors.white)),
              onPressed:() async {
                //print(_user.getEmail);
                //print(_user.getSenha);
                dynamic result = await _authController.registrarUsuario(_user);
                if(result == null) print("erro");
              },

            ),
            SizedBox(height: 12),
            Obx(() => Text(_authController.dialogError.value, style: TextStyle(color:Colors.red, fontSize:12))),
          ]
      ),
    );

  }
}