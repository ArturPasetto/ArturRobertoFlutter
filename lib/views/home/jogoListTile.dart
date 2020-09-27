
import 'package:artur_roberto_flutter/controllers/jogoController.dart';
import 'package:artur_roberto_flutter/models/algoUserModel.dart';
import 'package:artur_roberto_flutter/models/jogoModel.dart';
import 'package:artur_roberto_flutter/views/home/jogoList.dart';
import 'package:artur_roberto_flutter/views/home/homeView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class JogoListTile extends StatelessWidget {

  final JogoModel jogo;
  JogoController _jogoController = JogoController();

  JogoListTile({this.jogo});

  @override
  Widget build(BuildContext context) {

    return FlatButton(
        onPressed: (){
          Get.dialog(AlertDialog(
              title: Text('Confirmar ação'),
              content: Text('Você realmente deseja excluir?'),
              actions: <Widget>[
                FlatButton(
                    child: Text('Sim'),
                    onPressed: ()  async{
                      bool result = await _jogoController.excluirJogo(jogo.uid);
                      Get.back();

                      if(result){
                        GetBar(
                          messageText: Center(
                            child:Text(
                                'Excluido com sucesso',
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
                              child: Text(
                                  'Algo inesperado aconteceu',
                                  style: TextStyle(color: Colors.white)
                              )
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 4)
                        ).show();
                      }

                    }
                ),
                FlatButton(
                  child:Text('Não'),
                  onPressed: (){
                    Get.back();
                  },
                ),
              ]
          ));
        },
        child: Container(
          margin: EdgeInsets.only(top: 8.0),
          child:Card(
              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
              child:ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.pink[300],
                ),
                title: Text(jogo.nome),
                subtitle: Text(jogo.descricao + ' ' + jogo.ano.toString()),
              )
          ),
        )
    );
  }


}