import 'package:flutter/material.dart';


InputDecoration getInput ({
  required String label,
  required bool senha,
  required bool textoOculto,
  required VoidCallback senhaVisivel,
}){



  return InputDecoration(

    labelText: label,
    labelStyle: TextStyle(
        color: Color(0xFF18383A)
    ),

    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF18383A),width: 2)
    ),

    suffixIcon: senha ? IconButton(
        onPressed: senhaVisivel,

        icon: Icon(
        textoOculto ? Icons.visibility_off : Icons.visibility,
  color: Color(0xFF18383A),
  ),):null,

    errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red,width: 1)
    ),

    focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red,width: 2)
    ),

  );

}

