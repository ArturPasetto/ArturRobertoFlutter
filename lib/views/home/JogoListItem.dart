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

  var _isVisibile = false.obs;

  @override
  Widget build(BuildContext context) {

        return Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                child: Row(
                  children: [
                    Flexible(
                        child:Container(
                            decoration: BoxDecoration(
                              //color: ThemeColors.CARD_JOGO_BAKCGROUND,
                              boxShadow: [
                                BoxShadow(
                                  color: ThemeColors.SECUNDARY_COLOR,
                                  blurRadius: 1,
                                  offset: Offset(0,0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage('assets/img2.jpg'),
                                //child: Image.asset('assets/img1.jpg', fit: BoxFit.fill,),
                              ),
                              title: Text(jogo.nome, style: TextStyles.CARD_JOGO_TITULO),
                              trailing: Obx(() =>  _isVisibile.value ? Icon(Icons.arrow_upward, color: Colors.white) : Icon(Icons.arrow_downward, color: Colors.white)),
                              onTap:() => _isVisibile.value = !_isVisibile.value ,
                            )
                        )
                    )
                  ],
                )
              ),
              Obx(() => Visibility(
                  visible: _isVisibile.value,
                  child:  Container(
                      decoration: BoxDecoration(
                        //color: ThemeColors.CARD_JOGO_BAKCGROUND,
                        boxShadow: [
                          BoxShadow(
                            color: ThemeColors.SECUNDARY_COLOR,
                            blurRadius: 1,
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
                                  //fit: FlexFit.tight,
                                  child: Row(
                                    children: [
                                      Flexible(
                                          child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children:[
                                                Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                                                                    backgroundColor: ThemeColors.PRIMARY_COLOR,
                                                                    title: Text('Confirmar ação', style: TextStyle(color: Colors.white)),
                                                                    content: Text('Você realmente deseja excluir?', style: TextStyle(color: Colors.white)),
                                                                    actions: <Widget>[
                                                                      FlatButton(
                                                                        color: Color(0xFF434273),
                                                                        shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                                                        child:Text('Não', style: TextStyle(color: Colors.red)),
                                                                        onPressed: () => Get.back(),
                                                                      ),
                                                                      FlatButton(
                                                                          child: Text('Sim', style: TextStyle(color: Colors.green)),
                                                                          color: Color(0xFF434273),
                                                                          shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
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
                              ),
                            ],
                          )
                      )
                  )
              ) ),

            ],
          )
        );
  }


}