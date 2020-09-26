import 'package:artur_roberto_flutter/controllers/algoController.dart';
import 'package:artur_roberto_flutter/models/algoUserModel.dart';
import 'package:artur_roberto_flutter/styles/styles.dart';
import 'package:artur_roberto_flutter/utils/banco.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homeView.dart';

class SettingsFormView extends StatelessWidget{

  final _formKeySettings = GlobalKey<FormState>();
  final AlgoController _algoController = AlgoController();

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
      stream: this._algoController.getUserAlgo,
      builder: (context, snapshot){
        if(snapshot.hasData){

          AlgoUserModel algoUserModel = snapshot.data;

          this.setarValores(algoUserModel.um, algoUserModel.dois, algoUserModel.quatro);

          return Scaffold(
            backgroundColor: Colors.grey[100],
            body: Center(
                child:Form(
                  key:this._formKeySettings,
                  child: Column(
                    children: <Widget>[
                      Text('Atualizar suas configurações', style: TextStyle(fontSize:18)),
                      SizedBox(height:40.0),
                      DropdownButtonFormField<String>(
                        value: this._listaUm.elementAt(this._listaUm.indexOf(algoUserModel.dois)),//algoUserModel.dois,
                        items:  this._listaUm.map((valor) {
                          return DropdownMenuItem<String>(
                              value: valor,
                              child:Text('$valor valor')
                          );
                        }).toList(),
                        onChanged: (valor) => this._currentDois.value = this._listaUm.elementAt(this._listaUm.indexOf(valor)),
                      ),
                      Obx(() => Slider(
                        value: this._currentQuatro.value.toDouble(),
                        activeColor: Colors.pink[this._currentQuatro.value ?? algoUserModel.quatro.toInt()],
                        inactiveColor: Colors.pink[this._currentQuatro.value],
                        min:100,
                        max: 900,
                        divisions: 8,
                        onChanged: (valor) => this._currentQuatro.value = valor.round(),
                        label: this._currentQuatro.value.toString(),
                      )),
                      SizedBox(height: 20.0,),
                      TextFormField(
                        initialValue: algoUserModel.um,
                        decoration: textFormFieldDecoration,
                        validator: (valor) => valor.isEmpty ? 'Erro' : null,
                        onChanged: (valor) => this._currentUm.value = valor,
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        color: Colors.blue,
                        child: Text("Atualizar", style: TextStyle(color: Colors.white),),
                        onPressed: () async{
                          print(this._currentUm.value);
                          print(this._currentDois.value);
                          //print(this._currentTres);
                          print(this._currentQuatro.value);
                          if(this._formKeySettings.currentState.validate()){
                            await this._algoController.atualizarDadosUsuario(
                                this._currentUm.value,
                                this._currentDois.value,
                                'xxx',
                                this._currentQuatro.value,
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