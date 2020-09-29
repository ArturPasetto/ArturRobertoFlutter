import 'package:artur_roberto_flutter/controllers/jogoController.dart';
import 'package:artur_roberto_flutter/models/algoUserModel.dart';
import 'package:artur_roberto_flutter/models/jogoModel.dart';
import 'package:artur_roberto_flutter/styles/theme.dart';
import 'package:artur_roberto_flutter/utils/banco.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';



class EditarJogoView extends GetView<JogoController>{



  final List<int> _listaAno = List<int>();
  final _editFormKey = GlobalKey<FormState>();
  final JogoModel jogo;

  EditarJogoView({this.jogo});

  void criarListas(){


    _listaAno.removeRange(0, _listaAno.length);
    int i=0;
    for(i=0;i<=20;i++){
      _listaAno.add(2000+i);
    }

    //_jogo.ano = _listaAno.elementAt(0);
  }


  @override
  Widget build(BuildContext context) {

    this.criarListas();

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: ThemeColors.APP_BAR_BACKGROUND,
        elevation: 0.0,
        centerTitle: true,
        title:Text("Atualizar Jogo"),
      ),
      body: Container(
          color: ThemeColors.ADD_JOGO_BACKGROUND,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Form(
                key:_editFormKey,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height:20),
                    TextFormField(
                        style: TextStyles.FORMFIELD ,
                        decoration: TextStyles.FORMFIELD_DECORATION.copyWith(labelText: 'Nome'),
                        initialValue: jogo.nome,
                        onSaved: (value) => jogo.nome = value,
                        onChanged: (value) => jogo.nome = value,
                        validator: (value) => value.isEmpty ? 'Nome não pode ser vazio' : null
                    ),
                    SizedBox(height:20),
                    TextFormField(
                        style: TextStyles.FORMFIELD ,
                        decoration: TextStyles.FORMFIELD_DECORATION.copyWith(labelText: 'Descrição'),
                        initialValue: jogo.descricao,
                        onSaved: (value) => jogo.descricao = value,
                        onChanged: (value) => jogo.descricao = value,
                        validator: (value) => value.isEmpty || value.isNullOrBlank ? 'Descrição não pode ser vazio' : null
                    ),
                    SizedBox(height:20),
                    DropdownButtonFormField<int>(
                      style: TextStyles.FORMFIELD,
                      decoration: TextStyles.FORMFIELD_DECORATION.copyWith(labelText: 'Ano'),
                      dropdownColor: ThemeColors.ADD_JOGO_FORMFIELD_BACKGROUND,
                      value: _listaAno.elementAt(_listaAno.indexOf(jogo.ano)),
                      items:  _listaAno.map((valor) {
                        return DropdownMenuItem<int>(
                            value: valor,
                            child:Text(valor.toString())
                        );
                      }).toList(),
                      onChanged: (valor) => jogo.ano = _listaAno.elementAt(_listaAno.indexOf(valor)),
                    ),
                    SizedBox(height:20),
                    FlatButton(
                      color: Color(0xFF434273),
                      shape: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      textColor: Colors.black ,
                      child: Text('Atualizar jogo', style: TextStyle(color: Colors.white)),
                      onPressed: () async{

                        if(!_editFormKey.currentState.validate()){
                          return null;
                        }
                        else {
                          _editFormKey.currentState.save();
                          bool result = await controller.atualizarJogo(this.jogo);
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
                    ),
                  ],
                )
            )
        )
      ),
    );
  }

}
