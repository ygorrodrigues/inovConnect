import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {

  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final double tamanhoFonte;
  final double padLeft;
  final double padRight;
  final double padTop;
  final double padBottom;
  final TextInputType tipoInput;
  final bool obscuro;

  const CampoTexto({
   this.controlador,
   this.rotulo, 
   this.tamanhoFonte,
   this.tipoInput,
   this.dica,
   this.padLeft,
   this.padRight,
   this.padTop,
   this.padBottom, 
   this.obscuro
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
        controller: controlador,
        keyboardType: tipoInput != null ? tipoInput : TextInputType.text,
        maxLines: tipoInput != null ? null : 1,
        style: TextStyle(
          fontSize: tamanhoFonte
        ),
        decoration: InputDecoration(
          labelText: rotulo != null ? rotulo : '',
          hintText: dica != null ? dica : '',
          border: OutlineInputBorder()
        ),
      ),
    );
  }
}