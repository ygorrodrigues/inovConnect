import 'package:flutter/material.dart';
import 'package:inov_connect/http/webclients/types_and_categories.dart';

final TypesAndCategoriesWebClient _typesAndCategoriesWebClient = 
  TypesAndCategoriesWebClient();

class FilterDialog extends StatefulWidget {

  final String message;
  final Widget redirWidget;
  final ValueChanged<List<int>> onSelectedOkDialog;

  const FilterDialog({
    this.message,
    this.redirWidget,
    this.onSelectedOkDialog
  });

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {

  String _typeSelection;
  String _categorySelection;
  List<Map> _dropdownTypes = [{ 'id': 0, 'name': 'Todos' }];
  List<Map> _dropdownCategories = [{ 'id': 0, 'name': 'Todos' }];

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
    return AlertDialog(
      title: Text(widget.message),
      content: Container(
        child: _dropdownCategories.length > 1 ? Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: DropdownButton<String>(
                hint: Text('Tipo de publicação'),
                value: _typeSelection,
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
            Container(
              child: DropdownButton<String>(
                hint: Text('Categoria da publicação'),
                value: _categorySelection,
                onChanged: (String newValue) {
                  setState(() {
                    _categorySelection = newValue;
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
            )
          ],
        ) : 
        Center(child: CircularProgressIndicator()),
      ),
      actions: <Widget>[
        FlatButton(onPressed: () {
          int typeSelected = _typeSelection != null ?
            int.parse(_typeSelection) : 0;
          int categorySelected = _categorySelection != null ?
            int.parse(_categorySelection) : 0;
          widget.onSelectedOkDialog([typeSelected, categorySelected]);
          widget.redirWidget != null ?
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return widget.redirWidget;
              }
            ))
            : Navigator.pop(context);
        },
        child: Text('OK')
        )
      ],
    );
  }
}