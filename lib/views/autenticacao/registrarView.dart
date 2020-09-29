import 'package:artur_roberto_flutter/controllers/userController.dart';
import 'package:artur_roberto_flutter/models/userModel.dart';
import 'package:artur_roberto_flutter/views/home/homeView.dart';
import 'package:flutter/material.dart';
import 'package:artur_roberto_flutter/styles/theme.dart';
import 'package:get/get.dart';
import 'loginView.dart';


class RegistrarView extends StatelessWidget{

  final _registrarFormKey = GlobalKey<FormState>();
  final UserController _userController = Get.put(UserController());
  var _dialogError = ''.obs;
  var _ocultarSenha = true.obs;
  UserModel _user = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar:AppBar(
            backgroundColor: ThemeColors.APP_BAR_BACKGROUND,
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
            color: ThemeColors.HOME_BACKGROUND,
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal:25.0),
            child: Form(
              key: this._registrarFormKey,
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
                        onSaved: (value) => _user.setEmail = value,
                        validator: (value) => value.isEmpty ? 'Email não pode ser vazio' : null
                    ),
                    SizedBox(height:20),
                    Obx(() => TextFormField(
                        obscureText: _ocultarSenha.value,
                        style: TextStyles.FORMFIELD,
                        decoration: TextStyles.FORMFIELD_DECORATION.copyWith(
                            labelText: 'Senha',
                            suffixIcon: IconButton(
                              icon: Icon(
                                  _ocultarSenha.value ? Icons.visibility : Icons.visibility_off
                              ),
                              color: Colors.white,
                              onPressed: () {
                                _ocultarSenha.value = !_ocultarSenha.value;
                              },
                            ),
                            icon: Icon(Icons.lock, color: Colors.white)
                        ),
                        onSaved: (value) => _user.setSenha = value,
                        validator: (value) => value.isEmpty ? 'Senha não pode ser vazia' : null
                    )),
                    SizedBox(height:20),
                    FlatButton(
                      color: Color(0xFF434273),
                      shape: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      textColor: Colors.black ,
                      child: Text('Registrar', style: TextStyle(color: Colors.white)),
                      onPressed:() async {

                        if(!_registrarFormKey.currentState.validate()){
                          return null;
                        }
                        else {
                          _registrarFormKey.currentState.save();

                          dynamic result = await _userController.registrarUsuario(_user);
                          if(result == null) {
                            print(result);
                            this._dialogError.value = "Não foi possível registrar-se com essas credenciais";
                          }
                          else Get.to(Home());
                        }

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
