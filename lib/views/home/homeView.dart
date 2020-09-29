import 'package:artur_roberto_flutter/controllers/jogoController.dart';
import 'package:artur_roberto_flutter/controllers/loginController.dart';
import 'package:artur_roberto_flutter/models/algoUserModel.dart';
import 'package:artur_roberto_flutter/models/jogoModel.dart';
import 'package:artur_roberto_flutter/styles/theme.dart';
import 'package:artur_roberto_flutter/utils/banco.dart';
import 'package:artur_roberto_flutter/views/autenticacao/loginView.dart';
import 'package:artur_roberto_flutter/views/home/settingsFormView.dart';
import 'package:artur_roberto_flutter/views/jogo/addJogoView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'jogoList.dart';

class Home extends StatelessWidget{

  LoginController _loginController = Get.find<LoginController>();
  JogoController _jogoController = JogoController();
  var _isSearching = false.obs;


  FloatingActionButton _fab =  FloatingActionButton(
    onPressed: () =>  Get.to(AdicionarJogoView()),
    backgroundColor: Color(0xFF434273),
    shape: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(50)
    ),
    child: Icon(Icons.add),
  );


  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<JogoModel>>.value(
      value: JogoController().getListaJogosUser,
      child: Scaffold(
        backgroundColor: ThemeColors.HOME_BACKGROUND,
        appBar: AppBar(
          leading: IconButton(
              icon: Obx(() => _isSearching.value ? Icon(Icons.close) : Icon(Icons.search)),
              onPressed: () => _isSearching.value = !_isSearching.value
          ),
          title: Obx(() => _isSearching.value ? TextField(
              style: TextStyles.FORMFIELD,
              decoration: TextStyles.FORMFIELD_DECORATION,
              textInputAction: TextInputAction.done,
              onSubmitted: (pesquisa) async{
                //print(pesquisa);
                _isSearching.value = false;
              },
            ) : Text('Home', style: TextStyle(color: Colors.white),)
          ),
          backgroundColor: ThemeColors.APP_BAR_BACKGROUND,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon:Icon(Icons.person,  color: Colors.white,),
              label: Text('Logout', style: TextStyle(color: Colors.white),),
              onPressed: () async{
                await _loginController.deslogar();
                Get.offAll(LoginView());
              },
            ),
          ],
        ),
        body: JogoList(),
        floatingActionButton: _fab,
      ),
    );
  }

}








