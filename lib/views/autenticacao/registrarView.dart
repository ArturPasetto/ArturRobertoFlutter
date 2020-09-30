import 'package:artur_roberto_flutter/controllers/userController.dart';
import 'package:artur_roberto_flutter/models/userModel.dart';
import 'package:artur_roberto_flutter/views/home/homeView.dart';
import 'package:flutter/material.dart';
import 'package:artur_roberto_flutter/styles/theme.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'loginView.dart';


bool isLarge = false;

class RegistrarViewScreen extends StatelessWidget{

  UserModel _usuario = UserModel();
  MaskedTextController _maskController = MaskedTextController(mask: '(00) 00000-0000');
  GlobalKey<FormState> _registrarFormKey = GlobalKey<FormState>();
  final UserController _userController = Get.put(UserController());
  var _dialogError = ''.obs;
  var _ocultarSenha = true.obs;
  var _datanascimento = DateTime.now().obs;


  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[100],
        appBar:AppBar(
          backgroundColor: ThemeColors.SECUNDARY_COLOR,
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
        body: SizedBox.expand(
          child: FractionallySizedBox(
            widthFactor: isLarge ? 0.25 : 1.0,
            alignment: FractionalOffset.center,
            child: Container(
                color: ThemeColors.PRIMARY_COLOR,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal:25.0),
                child: Form(
                  key: this._registrarFormKey,
                  child:Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                      children:<Widget>[
                        SizedBox(height:20),
                        TextFormField(
                            style: TextStyles.FORMFIELD,
                            decoration: TextStyles.FORMFIELD_DECORATION.copyWith(
                                labelText: 'Email',
                                icon: Icon(Icons.email, color: Colors.white)
                            ),
                            onSaved: (value) => _usuario.email = value,
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
                            onSaved: (value) => _usuario.setSenha = value,
                            validator: (value) => value.isEmpty ? 'Senha não pode ser vazia' : null
                        )),
                        SizedBox(height:20),
                        TextFormField(
                            style: TextStyles.FORMFIELD,
                            decoration: TextStyles.FORMFIELD_DECORATION.copyWith(
                                labelText: 'Nome',
                                icon: Icon(Icons.person, color: Colors.white)
                            ),
                            onSaved: (value) => _usuario.nome = value,
                            validator: (value) => value.isEmpty ? 'Nome não pode ser vazio' : null
                        ),
                        SizedBox(height:20),
                        TextFormField(
                            controller: _maskController,
                            keyboardType: TextInputType.number,
                            style: TextStyles.FORMFIELD,
                            decoration: TextStyles.FORMFIELD_DECORATION.copyWith(
                                labelText: 'Telefone',
                                icon: Icon(Icons.phone, color: Colors.white)
                            ),
                            onSaved: (value) => _usuario.telefone = value,
                            validator: (value) => value.numericOnly().length<11 ? 'O número de telefone não é valido' : null
                        ),
                        SizedBox(height:20),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: Colors.white),
                            SizedBox(width: 12.5),
                            Expanded(
                              child:  FlatButton(
                                child: Text('Selecione sua Data de Nascimento', style: TextStyles.FORMFIELD),
                                color: ThemeColors.TERCIARY_COLOR,
                                onPressed: () async {
                                  _datanascimento.value = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(2000),
                                      initialDate: _datanascimento.value,
                                      lastDate: DateTime.now(),
                                      builder: (BuildContext context, Widget child){
                                        return Theme(
                                            data: ThemeData.dark(),
                                            child: child
                                        );
                                      }
                                  );
                                  if(_datanascimento.value.isNull) {
                                    _dialogError.value = 'Selecione uma data';
                                    _datanascimento.value = DateTime.now();
                                  }
                                  else _dialogError.value = '';
                                },
                              ),
                            ),
                          ],
                        ),
                        Obx(() => Text(_dialogError.value, style: TextStyle(color: Colors.red))),
                        FlatButton(
                          color: Color(0xFF434273),
                          shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          textColor: Colors.black ,
                          child: Text('Registrar', style: TextStyle(color: Colors.white)),
                          onPressed:() async {

                            if(!_registrarFormKey.currentState.validate()){
                              return null;
                            }
                            else {
                              _registrarFormKey.currentState.save();
                              _usuario.aniversario = _datanascimento.value;

                              dynamic result = await _userController.registrarUsuario(_usuario);
                              if(result == null) {
                                print(result);
                                this._dialogError.value = "Não foi possível registrar-se com essas credenciais";
                              }
                              else Get.to(Home());
                            }

                          },
                        ),
                        SizedBox(height: 12),
                      ]
                  ),
                )
            )
          )
        )
    );
  }

}

class RegistrarView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          constraints.maxWidth < 600 ? isLarge = false : isLarge = true;
          return RegistrarViewScreen();
        }
    );
  }
  
}
