import 'package:flutter/material.dart';
import 'package:inov_connect/components/example_dialog.dart';
import 'package:inov_connect/http/webclients/posts_webclient.dart';
import 'package:inov_connect/http/webclients/types_and_categories.dart';
import 'package:inov_connect/screens/bottom/bottom_template.dart';

final TypesAndCategoriesWebClient _typesAndCategoriesWebClient = 
  TypesAndCategoriesWebClient();
final PostsWebClient _postsWebClient = PostsWebClient();

class FormPost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormPostState();
  }
}

class FormPostState extends State<FormPost> {
  final TextEditingController _controllerTitle =
    TextEditingController();
  final TextEditingController _controllerAnotherCategory =
    TextEditingController();
  final TextEditingController _controllerDescription =
    TextEditingController();

  String _typeSelection;
  String _firstCategorySelection;
  String _secondCategorySelection;
  List<Map> _dropdownCategories = [{ 'id': 0, 'name': 'Selecione uma categoria' }];
  List<Map> _dropdownTypes = [{ 'id': 0, 'name': 'Selecione o tipo' }];

  @override
  void initState() {
    super.initState();
    _typesAndCategoriesWebClient.listTypesAndCategories()
      .then((result) {
        _dropdownTypes = result['types'];
        _dropdownCategories = result['categories'];
        setState(() {});
      });
  }

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
            top: 50,
            bottom: 25,
          ),
          child: _dropdownCategories.length > 1 ?
          Padding(
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
                    controller: _controllerTitle,
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
                    'Primeira categoria',
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
                        value: _firstCategorySelection,
                        icon: Icon(Icons.keyboard_arrow_down),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        underline: Container(
                          color: Colors.white,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            _firstCategorySelection = newValue;
                          });
                        },
                        items: _dropdownCategories
                          .map<DropdownMenuItem<String>>((Map map) {
                            return DropdownMenuItem<String>(
                              value: map['id'].toString(),
                              child: Text(map['name'])
                            );
                          }).toList(),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Segunda categoria',
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
                        value: _secondCategorySelection,
                        icon: Icon(Icons.keyboard_arrow_down),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        underline: Container(
                          color: Colors.white,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            _secondCategorySelection = newValue;
                          });
                        },
                        items: _dropdownCategories
                          .map<DropdownMenuItem<String>>((Map map) {
                            return DropdownMenuItem<String>(
                              value: map['id'].toString(),
                              child: Text(map['name'])
                            );
                          }).toList(),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Outra categoria',
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
                    controller: _controllerAnotherCategory,
                    keyboardType: TextInputType.text,
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
                    'Tipo',
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
                        value: _typeSelection,
                        icon: Icon(Icons.keyboard_arrow_down),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        underline: Container(
                          color: Colors.white,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            _typeSelection = newValue;
                          });
                        },
                        items: _dropdownTypes
                          .map<DropdownMenuItem<String>>((Map map) {
                            return DropdownMenuItem<String>(
                              value: map['id'].toString(),
                              child: Text(map['name'])
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
                    controller: _controllerDescription,
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
                      onPressed: () {
                        _createPost(context);
                      },
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
          ) : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  void _createPost(BuildContext context) {
    final String title = _controllerTitle.text;
    final String anotherCategory = _controllerAnotherCategory.text;
    final String description = _controllerDescription.text;
    int typeSelected = _typeSelection != null ?
      int.parse(_typeSelection) : 0;
    int firstCategorySelected = _firstCategorySelection != null ?
      int.parse(_firstCategorySelection) : 0;
    int secondCategorySelected = _secondCategorySelection != null ?
      int.parse(_secondCategorySelection) : 0;

    final int sumOfCategories = firstCategorySelected + secondCategorySelected;

    if((_firstCategorySelection != _secondCategorySelection) || 
      (sumOfCategories == 0 && anotherCategory.length > 0)) {
      Map<String, dynamic> newPost = {
        'title': title,
        'anotherCategory': anotherCategory,
        'description': description,
        'type': typeSelected,
        'firstCategory': firstCategorySelected,
        'secondCategory': secondCategorySelected
      };
    
      _postsWebClient.saveNewPost(newPost)
        .then((resp) {
          showDialog(
            context: context,
            builder: (context) {
              return ExampleDialog(
                message: 'Publicação criada, verifique suas publicações.',
                redirWidget: BottomTemplate(firstIndex: 1),
              );
            }
          );
        })
        .catchError((err) {
          String error = err.toString();
          List<dynamic> message = error.split(': ');
          showDialog(
            context: context,
            builder: (context) {
              return ExampleDialog(
                message: message[message.length - 1]
              );
            }
          );
        });
    }
    else {
      showDialog(
        context: context,
        builder: (context) {
          return ExampleDialog(
            message: 'Selecione categorias diferentes ' +
              'ou digite uma categoria para sua publicação',
          );
        }
      );
    }
    
  }
}
