import 'package:artur_roberto_flutter/controllers/loginController.dart';
import 'package:artur_roberto_flutter/models/userModel.dart';
import 'package:artur_roberto_flutter/views/autenticacao/registrarView.dart';
import 'package:artur_roberto_flutter/styles/theme.dart';
import 'package:artur_roberto_flutter/views/home/homeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginView extends StatelessWidget{

  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.put(LoginController());
  var _dialogError = ''.obs;
  var _ocultarSenha = true.obs;

  UserModel _user = UserModel();


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     resizeToAvoidBottomInset: false,
     backgroundColor: ThemeColors.PRIMARY_COLOR,
     appBar:AppBar(
       backgroundColor: ThemeColors.SECUNDARY_COLOR,
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
               mainAxisAlignment: MainAxisAlignment.center,
               children:<Widget>[
                 SizedBox(height:20),
                 TextFormField(
                     style: TextStyles.FORMFIELD,
                     decoration: TextStyles.FORMFIELD_DECORATION.copyWith(
                         labelText: 'Email',
                         icon: Icon(Icons.email, color: Colors.white)
                     ),
                     onSaved: (value) => _user.email = value,
                     validator: (value) => value.isEmpty ? 'Email não pode ser vazio' : null
                 ),
                 SizedBox(height:20),
                 Obx(() => TextFormField(
                     obscureText: _ocultarSenha.value,
                     style: TextStyles.FORMFIELD,
                     decoration: TextStyles.FORMFIELD_DECORATION.copyWith(
                         labelText: 'Senha',
                         suffixIcon: IconButton(
                           icon: Icon(_ocultarSenha.value ? Icons.visibility : Icons.visibility_off),
                           color: Colors.white,
                           onPressed: () =>  _ocultarSenha.value = !_ocultarSenha.value,
                         ),
                         icon: Icon(Icons.lock, color: Colors.white)
                     ),
                     onSaved: (value) => _user.setSenha = value,
                     validator: (value) => value.isEmpty ? 'Senha não pode ser vazia' : null
                 )),
                 SizedBox(height:20),
                 FlatButton(
                   color: Color(0xFF434273),
                   shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                   child: Text('Logar', style: TextStyle(color: Colors.white)),
                   onPressed:() async {

                     if(!_loginFormKey.currentState.validate()){
                       return null;
                     }
                     else {
                       _loginFormKey.currentState.save();
                       dynamic result = await _loginController.logar(_user);

                       if(result == null) _dialogError.value = 'Não foi possível logar com essas credenciais';
                       else  Get.to(Home());
                     }

                     //else print(result);
                   },
                 ),
                 SizedBox(height: 12),
                 Obx(() => Text(_dialogError.value, style: TextStyle(color:Colors.red, fontSize:12))),
               ]
           ),
         )
     )
    );
  }


}