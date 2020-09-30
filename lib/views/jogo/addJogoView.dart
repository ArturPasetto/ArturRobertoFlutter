import 'package:artur_roberto_flutter/controllers/jogoController.dart';
import 'package:artur_roberto_flutter/models/jogoModel.dart';
import 'package:artur_roberto_flutter/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';



class AdicionarJogoView extends GetView<JogoController>{


  JogoModel _jogo = JogoModel();
  final List<int> _listaAno = List<int>();
  GlobalKey<FormState> _addJogoFormKey = GlobalKey<FormState>();
  
  void criarListas(){
    _listaAno.removeRange(0, _listaAno.length);
    int i=0;
    for(i=0;i<=20;i++){
      _listaAno.add(2000+i);
    }

    _jogo.ano = _listaAno.elementAt(0);
  }


  @override
  Widget build(BuildContext context) {

    this.criarListas();

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor:Colors.blue,
        elevation: 0.0,
        centerTitle: true,
        title:Text("Adicionar Jogo"),
      ),
      body: Container(
        color: ThemeColors.PRIMARY_COLOR,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Form(
                key:_addJogoFormKey,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                        style: TextStyles.FORMFIELD ,
                        decoration: TextStyles.FORMFIELD_DECORATION.copyWith(labelText: 'Nome'),
                        onSaved: (value) => _jogo.nome = value,
                        onChanged: (value) => _jogo.nome = value,
                        validator: (value) => value.isEmpty ? 'Nome não pode ser vazio' : null
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                        style: TextStyles.FORMFIELD ,
                        decoration: TextStyles.FORMFIELD_DECORATION.copyWith(labelText: 'Descrição'),
                        onSaved: (value) => _jogo.descricao = value,
                        onChanged: (value) => _jogo.descricao = value,
                        validator: (value) => value.isEmpty || value.isNullOrBlank ? 'Descrição não pode ser vazio' : null
                    ),
                    SizedBox(height: 20,),
                    DropdownButtonFormField<int>(
                      style: TextStyles.FORMFIELD,
                      decoration: TextStyles.FORMFIELD_DECORATION.copyWith(labelText: 'Ano'),
                      dropdownColor: ThemeColors.SECUNDARY_COLOR,
                      value: _listaAno.elementAt(0),
                      items: _listaAno.map((valor) {
                        return DropdownMenuItem<int>(
                            value: valor,
                            child:Text(valor.toString())
                        );
                      }).toList(),
                      onChanged: (valor) => _jogo.ano = _listaAno.elementAt(_listaAno.indexOf(valor)),
                    ),
                    SizedBox(height: 20,),
                    FlatButton(
                      color: Color(0xFF434273),
                      shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      textColor: Colors.black ,
                      child: Text('Cadastrar Jogo', style: TextStyle(color: Colors.white)),
                      onPressed: () async{

                        if(!_addJogoFormKey.currentState.validate()){
                          return null;
                        }
                        else {
                          _addJogoFormKey.currentState.save();
                          bool result =  await controller.adicionarJogo(_jogo, _addJogoFormKey);
                          Get.back();
                          if(result){
                            GetBar(
                              messageText: Center(
                                  child:Text(
                                      'Adicionado com sucesso',
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
