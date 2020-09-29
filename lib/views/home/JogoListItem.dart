import 'package:artur_roberto_flutter/controllers/jogoController.dart';
import 'package:artur_roberto_flutter/models/jogoModel.dart';
import 'package:artur_roberto_flutter/styles/theme.dart';
import 'package:artur_roberto_flutter/views/jogo/editJogoView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class JogoListItem extends GetView<JogoController> {

  final JogoModel jogo;
  JogoController _jogoController = Get.put(JogoController());

  JogoListItem({this.jogo});

  @override
  Widget build(BuildContext context) {

        return Container(
            /*decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.teal[100], Colors.cyan[100]],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 1]
              ),
            ),*/
            decoration: BoxDecoration(
              color: ThemeColors.CARD_JOGO_BAKCGROUND,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: ThemeColors.APP_BAR_BACKGROUND,
                  blurRadius: 5,
                  offset: Offset(0,0), // changes position of shadow
                ),
              ],
            ),
            margin: EdgeInsets.fromLTRB(20.0, 10, 20.0, 10.0),
            child:SizedBox(
                height:MediaQuery.of(context).size.height/4 ,
                width:MediaQuery.of(context).size.width,
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width:20),
                  Container(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/img2.jpg'),
                        //child: Image.asset('assets/img1.jpg', fit: BoxFit.fill,),
                      )
                  ),
                  Flexible(
                      fit: FlexFit.tight,
                      child: Row(
                        children: [
                          Flexible(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:[
                                    Text( //------------- Flexible aqui -------------
                                      jogo.nome,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.CARD_JOGO_TITULO ,
                                    ),
                                    SizedBox(height: 20,),
                                    Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 20),
                                        child: Text(
                                          jogo.descricao,
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(color: Colors.grey[500], fontSize: 15),
                                        )
                                    ),
                                    SizedBox(height: 10),
                                    Flexible(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(width: 20,),
                                          Expanded(
                                              child:Text(
                                                jogo.ano.toString(),
                                                style: TextStyle(color: Colors.grey[100], fontSize: 15),
                                              )
                                          ),
                                          Expanded(
                                              child: FlatButton(
                                                  child: Icon(Icons.edit, color: Colors.white),
                                                  onPressed: (){
                                                    Get.to(EditarJogoView(jogo: this.jogo));
                                                  }
                                              )
                                          ),
                                          Expanded(
                                              child: FlatButton(
                                                child: Icon(Icons.restore_from_trash_sharp, color: Colors.white),
                                                onPressed: (){
                                                  Get.dialog(AlertDialog(
                                                      backgroundColor: Colors.teal[50],
                                                      title: Text('Confirmar ação'),
                                                      content: Text('Você realmente deseja excluir?'),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                          color: Colors.red,
                                                          child:Text('Não'),
                                                          onPressed: (){
                                                            Get.back();
                                                          },
                                                        ),
                                                        FlatButton(
                                                            child: Text('Sim'),
                                                            color: Colors.green,
                                                            onPressed: ()  async{
                                                              Get.back();
                                                              bool result = await _jogoController.excluirJogo(jogo.uid);
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
                                                      ]
                                                  ));
                                                },
                                              )
                                          )
                                        ],
                                      )
                                    )
                                  ]
                              )
                          ),
                        ],
                      )
                  )
                ],
              )
            )
        );
  }


}