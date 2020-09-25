
import 'package:artur_roberto_flutter/controllers/autenticarController.dart';
import 'package:artur_roberto_flutter/models/userModel.dart';
import 'package:artur_roberto_flutter/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:artur_roberto_flutter/styles/formStyle.dart';
import 'package:get/get.dart';

import 'loginView.dart';



class RegistrarView extends StatelessWidget{

  final _registrarFormKey = GlobalKey<FormState>();
  final AutenticarController _autenticarController = AutenticarController();
  UserModel _user = UserModel();

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
                onPressed:() => Get.offAll(LoginView()),
          )
          ],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal:25.0),
            child: Form(
              key: this._registrarFormKey,
              child:Column(
                  children:<Widget>[
                    SizedBox(height:20),
                    TextFormField(
                      decoration: textFormFieldDecoration.copyWith(labelText: 'Email'),
                      onSaved: (value) => _user.setEmail = value,
                      validator: (value){
                        if(value.isEmpty) _autenticarController.dialogError.value = "Email não pode ser vazio";
                        else if (!value.contains('@')) _autenticarController.dialogError.value = "Email não é válido";
                        return null;
                      },
                    ),
                    SizedBox(height:20),
                    TextFormField(
                        obscureText: true,
                        decoration:textFormFieldDecoration.copyWith(labelText: 'Senha'),
                        onSaved: (value) => _user.setSenha = value,
                        validator: (value){
                          if(value.isEmpty) _autenticarController.dialogError.value = "Senha não pode ser vazia";
                          else if (value.length < 6) _autenticarController.dialogError.value = "Senha deve conter no mínimo 6 caracteres";
                          return null;
                        }
                    ),
                    SizedBox(height:20),
                    RaisedButton(
                      color: Colors.blue,
                      child: Text('Registrar', style: TextStyle(color: Colors.white)),
                      onPressed:() async {
                        dynamic result = await _autenticarController.registrarUsuario(_user, _registrarFormKey);
                        if(result == null) _autenticarController.dialogError.value = "Não foi possível registrar-se com essas credenciais";
                        else Get.to(Home());
                      },

                    ),
                    SizedBox(height: 12),
                    Obx(() => Text(_autenticarController.dialogError.value, style: TextStyle(color:Colors.red, fontSize:12))),
                  ]
              ),
            )
        )
    );
  }
  
}
