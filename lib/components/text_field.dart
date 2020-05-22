import 'package:flutter/material.dart';

class InovTextField extends StatelessWidget {

  final TextEditingController controller;
  final String label;
  final String hint;
  final double inputSize;
  final double padLeft;
  final double padRight;
  final double padTop;
  final double padBottom;
  final TextInputType inputType;
  final bool obscure;
  final Color fontColor;
  final double labelSize;
  final IconData icon;

  const InovTextField({
   this.controller,
   this.label, 
   this.inputSize,
   this.inputType,
   this.hint,
   this.padLeft,
   this.padRight,
   this.padTop,
   this.padBottom, 
   this.obscure,
   this.fontColor,
   this.labelSize,
   this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        padLeft != null ? padLeft : 0,
        padTop != null ? padTop : 0,
        padRight != null ? padRight : 0,
        padBottom != null ? padBottom : 0
      ),
      child: TextField(
        obscureText: obscure != null ? obscure : false,
        controller: controller,
        keyboardType: inputType != null ? inputType : TextInputType.text,
        maxLines: inputType != null ? null : 1,
        style: TextStyle(
          color: fontColor != null ? fontColor : Colors.black,
          fontSize: inputSize != null ? inputSize : 16.0
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8.0),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(
            icon,
            size: 32.0,
            color: Colors.black45
          ),
          labelText: label != null ? label : null,
          labelStyle: TextStyle(
            fontSize: labelSize != null ? labelSize : 16.0
          ),
          hintText: hint != null ? hint : '',
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.lightBlue[300],
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