import 'dart:ui';
import 'package:artur_roberto_flutter/controllers/jogoController.dart';
import 'package:artur_roberto_flutter/controllers/loginController.dart';
import 'package:artur_roberto_flutter/controllers/userController.dart';
import 'package:artur_roberto_flutter/models/jogoModel.dart';
import 'package:artur_roberto_flutter/styles/theme.dart';
import 'package:artur_roberto_flutter/utils/banco.dart';
import 'package:artur_roberto_flutter/views/autenticacao/loginView.dart';
import 'package:artur_roberto_flutter/views/jogo/addJogoView.dart';
import 'package:artur_roberto_flutter/views/usuario/editUsuarioView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'jogoList.dart';

class Home extends StatelessWidget{

  LoginController _loginController = Get.find<LoginController>();
  UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<JogoModel>>.value(
      value: JogoController().getListaJogosUser,
      child: Scaffold(
        backgroundColor: ThemeColors.PRIMARY_COLOR,
        appBar: AppBar(
          backgroundColor: ThemeColors.SECUNDARY_COLOR,
          title: Text('Home', style: TextStyle(color: Colors.white),),
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: (){
                Get.to(AdicionarJogoView());
              },
              icon: Icon(Icons.add_circle_outlined, color: Colors.white),
            )
          ],
        ),
        drawer: Drawer(
          child: Container(
            color: ThemeColors.PRIMARY_COLOR,
            child: ListView(
                children:[
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/img4.jpg')
                        )
                    ),
                    child: Center(
                      child: ClipRect(
                          child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                              child: Container(
                                  color: Colors.black.withOpacity(0.0),
                                  child: DrawerHeader(
                                      child: ListTile(
                                        title: Text(Banco.FIREBASE_AUTH.currentUser.displayName, style: TextStyles.DRAWER_TITULO,),
                                        subtitle: Text(Banco.FIREBASE_AUTH.currentUser.email, style: TextStyles.DRAWER_SUBTITULO),
                                      )
                                  )
                              )
                          )
                      )
                    ),
                  ),
                  ListTile(
                    title: Text('Adicionar Jogo', style: TextStyles.CARD_JOGO_TITULO),
                    leading: Icon(Icons.add, color: Colors.white,),
                    onTap: () {
                      Get.back();
                      Get.to(AdicionarJogoView());
                    },
                  ),
                  ListTile(
                    title: Text('Configurações', style: TextStyles.CARD_JOGO_TITULO),
                    leading: Icon(Icons.settings, color: Colors.white,),
                    onTap: () async {
                      Get.back();
                      await Get.to(EditarUsuarioView(usuario: await _userController.getDadosUsuario()));
                    },
                  ),
                  Divider(color: ThemeColors.TERCIARY_COLOR,),
                  ListTile(
                    title: Text('Deslogar', style: TextStyles.CARD_JOGO_TITULO),
                    leading: Icon(Icons.logout, color: Colors.white,),
                    onTap: () async {
                      await _loginController.deslogar();
                      Get.offAll(LoginView());
                    }
                  ),
                ]
            )
          )
        ),
        body: JogoList(),
        //floatingActionButton: _fab,
      ),
    );
  }

}








