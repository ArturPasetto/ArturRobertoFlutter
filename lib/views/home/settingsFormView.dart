/*
import 'package:artur_roberto_flutter/controllers/jogoController.dart';
import 'package:artur_roberto_flutter/models/algoUserModel.dart';
import 'package:artur_roberto_flutter/utils/banco.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homeView.dart';

class SettingsFormView extends StatelessWidget{

  final _formKeySettings = GlobalKey<FormState>();
  final JogoController _jogoController = JogoController();

  var _currentUm = "".obs;
  var _currentDois = "".obs;
  var _currentQuatro = 100.obs;
  //var _dialogError = "".obs;
  final List<String> _listaUm = ['1','2','3','4'];

  void setarValores(String um, String dois, int quatro){
    this._currentUm.value = um;
    this._currentDois.value = dois;
    this._currentQuatro.value = quatro;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AlgoUserModel>(
      stream: this._jogoController.getUserAlgo,
      builder: (context, snapshot){
        if(snapshot.hasData){

          AlgoUserModel algoUserModel = snapshot.data;

          this.setarValores(algoUserModel.um, algoUserModel.dois, algoUserModel.quatro);

          return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              centerTitle: true,
              title: Text('Atualizar suas configurações', style: TextStyle(fontSize:18)),
            ),
            body: Container(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child:Form(
                key: _formKeySettings,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    DropdownButtonFormField<String>(
                      value: _listaUm.elementAt(_listaUm.indexOf(algoUserModel.dois)),//algoUserModel.dois,
                      items:  _listaUm.map((valor) {
                        return DropdownMenuItem<String>(
                            value: valor,
                            child:Text('$valor valor')
                        );
                      }).toList(),
                      onChanged: (valor) => _currentDois.value = _listaUm.elementAt(_listaUm.indexOf(valor)),
                    ),
                    Obx(() => Slider(
                        value: _currentQuatro.value.toDouble(),
                        activeColor: Colors.pink[_currentQuatro.value ?? algoUserModel.quatro.toInt()],
                        inactiveColor: Colors.pink[_currentQuatro.value],
                        min:100,
                        max: 900,
                        divisions: 8,
                        onChanged: (valor) => _currentQuatro.value = valor.round(),
                        label: _currentQuatro.value.toString(),
                      )
                    ),
                    TextFormField(
                      initialValue: algoUserModel.um,
                      decoration: textFormFieldDecoration,
                      validator: (valor) => valor.isEmpty ? 'Erro' : null,
                      onChanged: (valor) => _currentUm.value = valor,
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      child: Text("Atualizar", style: TextStyle(color: Colors.white),),
                      onPressed: () async{
                        print(_currentUm.value);
                        print(_currentDois.value);
                        //print(this._currentTres);
                        print(_currentQuatro.value);
                        if(_formKeySettings.currentState.validate()){
                          await _jogoController.atualizarDadosUsuario(
                              _currentUm.value,
                              _currentDois.value,
                              'xxx',
                              _currentQuatro.value,
                              Banco.FIREBASE_AUTH.currentUser.uid);
                          Get.offAll(Home());
                        }
                      },
                    ),

                  ],
                ),
              )),
          );
        }
        else {
          snapshot.printError();
          return Scaffold(
            backgroundColor: Colors.blue,
          );
        }
      },
    );
  }

}

*/