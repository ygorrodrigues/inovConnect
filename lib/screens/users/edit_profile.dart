import 'package:flutter/material.dart';
import 'package:inov_connect/components/example_dialog.dart';
import 'package:inov_connect/http/webclients/courses.dart';
import 'package:inov_connect/http/webclients/user_webclient.dart';
import 'package:inov_connect/screens/bottom/bottom_template.dart';

class EditProfile extends StatefulWidget {

  final String name;
  final String description;
  final int courseId;

  const EditProfile({
    this.name,
    this.description,
    this.courseId
  });

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final CoursesWebClient _coursesWebClient = CoursesWebClient();
  final UserWebClient _userWebCliente = UserWebClient();

  final TextEditingController _controllerName =
    TextEditingController();
  final TextEditingController _controllerDescription =
    TextEditingController();

  String _courseSelection;
  List<Map> _dropdownCourses = [{ 'id': 0, 'name': 'Selecione seu curso' }];

  @override
  void initState() {
    super.initState();
    _coursesWebClient.listCourses().then((result) {
      _dropdownCourses = result;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(68.0),
                      ),
                      child: Image.asset(
                        'assets/images/personIcon128.jpg',
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nome',
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
                      controller: _controllerName,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8.0),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: widget.name,
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
                      'Curso',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.lightBlue[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.only(left: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      border: Border.all(
                        color: Colors.lightBlue[400]
                      )
                    ),
                    child: 
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text('Selecione seu curso'),
                        value: _courseSelection,
                        icon: Icon(Icons.keyboard_arrow_down),
                          style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            _courseSelection = newValue;
                          });
                        },
                        items: _dropdownCourses
                          .map<DropdownMenuItem<String>>((Map map) {
                            return DropdownMenuItem<String>(
                              value: map['id'].toString(),
                              child: Text(map['name'])
                            );
                          }).toList(),
                      ),
                    )
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
                        hintText: widget.description,
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
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonTheme(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                40.0,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.red[300],
                            child: Text(
                              'Voltar',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        ButtonTheme(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                40.0,
                              ),
                            ),
                            onPressed: () {
                              _editValidation(context);
                            },
                            color: Colors.lightBlue[300],
                            child: Text(
                              'Editar',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _editValidation(BuildContext context) {
    final String name = _controllerName.text == '' ?
      widget.name : _controllerName.text;
    final String description = _controllerDescription.text == '' ?
      widget.description : _controllerDescription.text;
    final String finalCourseSelection = _courseSelection == null ?
      widget.courseId.toString() : _courseSelection;
    
    _userWebCliente.updateUserData(name, description, finalCourseSelection)
      .then((resp) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return ExampleDialog(
              message: 'Seu perfil foi editado.',
              redirWidget: BottomTemplate(firstIndex: 0),
            );
          }
        );
      })
      .catchError((err) {
        String error = err.toString();
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return ExampleDialog(
              message: error
            );
          }
        );
      });
  }
}