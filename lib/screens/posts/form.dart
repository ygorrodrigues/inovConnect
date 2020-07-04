import 'package:flutter/material.dart';

class FormPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormPostState();
  }
}

class FormPostState extends State<FormPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          margin: EdgeInsets.only(
            left: 25,
            right: 25,
            top: 25,
            bottom: 50,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 26,
              right: 26,
              top: 26,
            ),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Título',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.lightBlue[400],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8.0,
                  ),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Digite um título',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlue[300],
                        ),
                        borderRadius: new BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Categoria',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.lightBlue[400],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 8.0,
                      ),
                      padding: const EdgeInsets.only(
                        left: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.lightBlue[400],
                        ),
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        underline: Container(
                          color: Colors.white,
                        ),
                        onChanged: (String newValue) {},
                        items: <String>[
                          'Selecione uma categoria',
                          'Hardware',
                          'Software',
                          'Física',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Outros',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.lightBlue[400],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Digite uma categoria',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlue[300],
                        ),
                        borderRadius: new BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Curso',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.lightBlue[400],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.only(left: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.lightBlue[400],
                        ),
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        underline: Container(
                          color: Colors.white,
                        ),
                        onChanged: (String newValue) {},
                        items: <String>[
                          'Selecione o tipo',
                          'PROJETO',
                          'DÚVIDA',
                          'GRUPO DE ESTUDOS',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Descrição',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.lightBlue[400],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    maxLines: 8,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Digite uma descrição',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8.0,
                          ),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlue[400],
                        ),
                        borderRadius: new BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    bottom: 16.0,
                  ),
                  child: ButtonTheme(
                    height: 80,
                    minWidth: 300,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          40.0,
                        ),
                      ),
                      onPressed: () {},
                      color: Colors.lightBlue[300],
                      child: Text(
                        'Criar',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
