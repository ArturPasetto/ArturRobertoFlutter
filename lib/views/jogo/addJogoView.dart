import 'package:artur_roberto_flutter/controllers/jogoController.dart';
import 'package:artur_roberto_flutter/models/algoUserModel.dart';
import 'package:artur_roberto_flutter/models/jogoModel.dart';
import 'package:artur_roberto_flutter/styles/styles.dart';
import 'package:artur_roberto_flutter/utils/banco.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';


class AdicionarJogoView extends StatelessWidget{


  final JogoController _jogoController = JogoController();
  JogoModel _jogo = JogoModel();
  final List<int> _listaAno = List<int>();
  final _addJogoFormKey = GlobalKey<FormState>();

  void criarListaAno(){
    _listaAno.removeRange(0, _listaAno.length);

    int i=0;
    for(i=0;i<=20;i++){
      _listaAno.add(2000+i);
    }

    _jogo.ano = _listaAno.elementAt(0);

  }

  @override
  Widget build(BuildContext context) {

    this.criarListaAno();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        centerTitle: true,
        title:Text("Adicionar Jogo"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          ),
          boxShadow: [BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3)
          )]
        ),
        child: Form(
          key:_addJogoFormKey,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                  decoration:textFormFieldDecoration.copyWith(
                      labelText: 'Nome',
                      icon: Icon(Icons.videogame_asset)
                  ),
                  onSaved: (value) => _jogo.nome = value,
                  validator: (value) => value.isEmpty ? 'Nome não pode ser vazio' : null
              ),
              DropdownButtonFormField<int>(
                value: _listaAno.elementAt(0),
                items:  this._listaAno.map((valor) {
                  return DropdownMenuItem<int>(
                      value: valor,
                      child:Text(valor.toString())
                  );
                }).toList(),
                onChanged: (valor) => _jogo.ano = _listaAno.elementAt(_listaAno.indexOf(valor)),
              ),
              TextFormField(
                  decoration:textFormFieldDecoration.copyWith(
                      labelText: 'Descrição',
                      icon: Icon(Icons.videogame_asset)
                  ),
                  onSaved: (value) => _jogo.descricao = value,
                  validator: (value) => value.isEmpty ? 'Descrição não pode ser vazio' : null
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text("Cadastrar", style: TextStyle(color: Colors.white),),
                onPressed: () async{
                  print(_jogo.ano);
                  _jogo.genero = [];
                  //await _jogoController.adicionarJogo(_jogo.nome, _jogo.ano, _jogo.descricao, _jogo.genero, _addJogoFormKey);
                  //Get.back();
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
                },
              ),
            ],
          )
        ),
      ),
    );
  }

}