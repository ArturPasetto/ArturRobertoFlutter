import 'package:artur_roberto_flutter/models/userModel.dart';
import 'package:artur_roberto_flutter/views/autenticacao/logar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../views/home/home.dart';

//classe que verifica se algum usuário logou,deslogou,cadastrou
class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    final usuario = Provider.of<UserModel>(context);

    if(usuario == null){
      return Logar();
    }

    return Home();
  }
}