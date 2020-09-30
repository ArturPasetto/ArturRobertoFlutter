import 'package:flutter/material.dart';

class ThemeColors{

  static const TERCIARY_COLOR = Color(0xFF736AB7);
  static const SECUNDARY_COLOR = Color(0xFF434273);
  static const PRIMARY_COLOR = Color(0xFF3E3963);

}


var textFormFieldDecoration =  InputDecoration(
  fillColor: Colors.grey[100],
  border: UnderlineInputBorder(),
  filled: true,
);

class TextStyles{

  static const CARD_JOGO_TITULO = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins'
  );

  static const DRAWER_TITULO = TextStyle(
      color: ThemeColors.PRIMARY_COLOR,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins'
  );

  static const DRAWER_SUBTITULO = TextStyle(
      color: ThemeColors.PRIMARY_COLOR,
      fontSize: 12,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins'
  );

  static const FORMFIELD_DECORATION = InputDecoration(
    labelStyle: TextStyle(color: Colors.grey,),
    fillColor: ThemeColors.SECUNDARY_COLOR,
    filled: true,
    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
  );

  static const FORMFIELD = TextStyle(
    color: Colors.white,
  );


}




