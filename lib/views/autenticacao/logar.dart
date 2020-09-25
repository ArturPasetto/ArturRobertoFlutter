import 'package:artur_roberto_flutter/controllers/loginController.dart';
import 'package:artur_roberto_flutter/models/userModel.dart';
import 'package:artur_roberto_flutter/views/autenticacao/registrar.dart';
import 'package:artur_roberto_flutter/styles/formStyle.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class Logar extends StatelessWidget{

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  LoginController _loginController = LoginController();
  UserModel _user = UserModel();


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.grey[100],
     appBar:AppBar(
       backgroundColor: Colors.blue,
       elevation: 0.0,
       title:Text("Login"),
       actions: <Widget>[
         FlatButton.icon(
           icon:Icon(Icons.person_add, color: Colors.white),
           label: Text('Registrar-se', style: TextStyle(color:Colors.white)),
           onPressed:() => Get.to(Registrar()),
         )
       ],
     ),
     body: Container(
         padding: EdgeInsets.symmetric(vertical: 20.0, horizontal:25.0),
         child:Form(
           key: _loginController.loginFormKey,
           child:Column(
             children:<Widget>[
               SizedBox(height:20),
               TextFormField(
                   decoration:textFormFieldDecoration.copyWith(labelText: 'Email'),
                   onSaved: (value) => _user.setEmail = value,
                   validator: (value) => value.isEmpty ? 'Email não pode ser vazio' : null
               ),
               SizedBox(height:20),
               TextFormField(
                  obscureText: true,
                  decoration:textFormFieldDecoration.copyWith(labelText: 'Senha'),
                  onSaved: (value) => _user.setSenha = value,
                  validator: (value) => value.isEmpty ? 'Senha não pode ser vazia' : null
               ),
               SizedBox(height:20),
               RaisedButton(
                 color: Colors.blue,
                 child: Text('Logar', style: TextStyle(color: Colors.white)),
                 onPressed:() async {
                   dynamic result = await _loginController.logar(_user);
                   if(result == null) _loginController.dialogError.value = "Não foi possível logar com essas credenciais";
                 },
               ),
               SizedBox(height: 12),
               Obx(() => Text(_loginController.dialogError.value, style: TextStyle(color:Colors.red, fontSize:12))),
             ]
           ),
         )
        )
    );
  }


}