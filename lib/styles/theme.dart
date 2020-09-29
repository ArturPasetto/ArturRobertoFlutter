import 'package:flutter/material.dart';


class ThemeColors{

  static const CARD_JOGO_BAKCGROUND = Color(0xFF434273);
  static const HOME_BACKGROUND = Color(0xFF3E3963);
  static const ADD_JOGO_BACKGROUND = Color(0xFF3E3963);
  static const ADD_JOGO_FORMFIELD_BACKGROUND = Color(0xFF434273);
  static const APP_BAR_BACKGROUND = Color(0xFF434273);

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

  static const FORMFIELD_DECORATION = InputDecoration(
    labelStyle: TextStyle(
      color: Colors.grey,
    ),
    fillColor: ThemeColors.ADD_JOGO_FORMFIELD_BACKGROUND,
    filled: true,
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  );

  static const FORMFIELD = TextStyle(
    color: Colors.white,
  );


}




