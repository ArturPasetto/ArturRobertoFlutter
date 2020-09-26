import 'package:artur_roberto_flutter/controllers/loginController.dart';
import 'package:artur_roberto_flutter/models/userModel.dart';
import 'package:artur_roberto_flutter/views/autenticacao/registrarView.dart';
import 'package:artur_roberto_flutter/styles/styles.dart';
import 'package:artur_roberto_flutter/views/home/homeView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginView extends StatelessWidget{

  final _loginFormKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.put(LoginController());
  var _dialogError = ''.obs;
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
           onPressed:() => Get.to(RegistrarView()),
         )
       ],
     ),
     body: Container(
         padding: EdgeInsets.symmetric(vertical: 20.0, horizontal:25.0),
         child:Form(
           key: this._loginFormKey,
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
                  dynamic result = await this._loginController.logar(_user, _loginFormKey);

                    if(result == null) this._dialogError.value = 'Não foi possível logar com essas credenciais';
                    else{
                      Get.to(Home());
                    }
                    //else print(result);
                 },
               ),
               SizedBox(height: 12),
               Obx(() => Text(this._dialogError.value, style: TextStyle(color:Colors.red, fontSize:12))),
             ]
           ),
         )
        )
    );
  }


}