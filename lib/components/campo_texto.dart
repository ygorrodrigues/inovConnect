import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {

  final TextEditingController controller;
  final String label;
  final String dica;
  final double tamanhoFonte;
  final double padLeft;
  final double padRight;
  final double padTop;
  final double padBottom;
  final TextInputType inputType;
  final bool obscuro;
  final Color fontColor;
  final double labelSize;

  const CampoTexto({
   this.controller,
   this.label, 
   this.tamanhoFonte,
   this.inputType,
   this.dica,
   this.padLeft,
   this.padRight,
   this.padTop,
   this.padBottom, 
   this.obscuro,
   this.fontColor,
   this.labelSize
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        padLeft != null ? padLeft : 8,
        padTop != null ? padTop : 0,
        padRight != null ? padRight : 8,
        padBottom != null ? padBottom : 0
      ),
      child: TextField(
        obscureText: obscuro != null ? obscuro : false,
        controller: controller,
        keyboardType: inputType != null ? inputType : TextInputType.text,
        maxLines: inputType != null ? null : 1,
        style: TextStyle(
          color: fontColor,
          fontSize: tamanhoFonte
        ),
        decoration: InputDecoration(
          labelText: label != null ? label : '',
          labelStyle: TextStyle(
            fontSize: labelSize
          ),
          hintText: dica != null ? dica : '',
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.lightBlue[400],
              width: 2,
            ),
            borderRadius: new BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}