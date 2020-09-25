

import 'package:flutter/material.dart';

void mostrarPainelConfiguracao(BuildContext context){
  showModalBottomSheet(context: context, builder: (context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
        child:Text("texto")
    );
  } );
}