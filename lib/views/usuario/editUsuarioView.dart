import 'package:artur_roberto_flutter/controllers/userController.dart';
import 'package:artur_roberto_flutter/models/userModel.dart';
import 'package:artur_roberto_flutter/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

class EditarUsuarioView extends GetView<UserController>{


  MaskedTextController _maskController = MaskedTextController(mask: '(00) 00000-0000');
  GlobalKey<FormState> _editFormKey = GlobalKey<FormState>();
  var _datanascimento = DateTime.now().obs;
  var _dialogError = ''.obs;
  final UserModel usuario;

  EditarUsuarioView({this.usuario});


  @override
  Widget build(BuildContext context) {

    _datanascimento.value = usuario.aniversario;
    _maskController.updateText(usuario.telefone);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ThemeColors.SECUNDARY_COLOR,
        elevation: 0.0,
        centerTitle: true,
        title:Text("Atualizar Dados"),
      ),
      body: Container(
        color: ThemeColors.PRIMARY_COLOR,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Form(
              key:_editFormKey,
              child: Column(
                children: [
                  TextFormField(
                      controller: _maskController,
                      keyboardType: TextInputType.number,
                      style: TextStyles.FORMFIELD,
                      decoration: TextStyles.FORMFIELD_DECORATION.copyWith(
                          labelText: 'Telefone',
                          icon: Icon(Icons.phone, color: Colors.white)
                      ),
                      onSaved: (value) => usuario.telefone = value,
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
                                firstDate: DateTime(1950),
                                initialDate: _datanascimento.value ?? usuario.aniversario,
                                lastDate: DateTime.now(),
                                builder: (BuildContext context, Widget child){
                                  return Theme(
                                      data: ThemeData.dark(),
                                      child: child
                                  );
                                }
                            );
                            if(_datanascimento.value.isNull) _dialogError.value = 'Selecione uma data';
                          },
                        ),
                      ),
                      Obx(() => Text(_dialogError.value, style: TextStyle(color: Colors.white)))
                    ],
                  ),
                  FlatButton(
                    color: Color(0xFF434273),
                    shape: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    textColor: Colors.black ,
                    child: Text('Atualizar dados', style: TextStyle(color: Colors.white)),
                    onPressed: () async{
                      if(!_editFormKey.currentState.validate()){
                        return null;
                      }
                      else {
                        _editFormKey.currentState.save();

                        usuario.aniversario = _datanascimento.value;

                        bool result = await controller.atualizarUsuario(this.usuario);
                        Get.back();
                        if(result){
                          GetBar(
                            messageText: Center(
                                child:Text(
                                    'Atualizado com sucesso',
                                    style: TextStyle(color: Colors.white)
                                )
                            ),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 4),
                          ).show();
                        }
                        else {
                          GetBar(
                            messageText: Center(
                                child:Text(
                                    'Aconteceu algo inesperado',
                                    style: TextStyle(color: Colors.white)
                                )
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 4),
                          ).show();
                        }
                      }
                    },
                  )
                ],
              ),
            )
        )
        ,
      ),
    );
  }

}
