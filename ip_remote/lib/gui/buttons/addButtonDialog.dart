import 'package:flutter/material.dart';

import 'package:ip_remote/bloc/lightModeProvider.dart';
import 'package:ip_remote/models/light_mode.dart';

class AddButtonDialog extends StatefulWidget {
  @override
  _AddButtonDialogState createState() => _AddButtonDialogState();
}

class _AddButtonDialogState extends State<AddButtonDialog> {
  TextEditingController _button = TextEditingController();
  TextEditingController _feedback = TextEditingController();
  TextEditingController _string = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        key: _scaffoldKey,
        body: ListView(
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(16)),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                keyboardAppearance: Brightness.dark,
                controller: _button,
                decoration: InputDecoration(
                  labelText: 'Button Text',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                keyboardAppearance: Brightness.dark,
                controller: _feedback,
                decoration: InputDecoration(
                  labelText: 'Feedback Message',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                keyboardAppearance: Brightness.dark,
                controller: _string,
                decoration: InputDecoration(
                  labelText: 'Request Path',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
              child: ButtonTheme(
                height: 50,
                child: Hero(
                  tag: "addButton",
                  child: ButtonTheme(
                    height: 60,
                    minWidth: 90,
                    child: RaisedButton(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Icon(Icons.add, size: 36),
                      onPressed: () => addLightMode(context),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addLightMode(BuildContext context) {
    LightMode lightMode = LightMode(
      _button.text,
      _feedback.text,
      _string.text,
    );
    if (_button.text == '' || _feedback.text == '' || _string.text == '') {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('No emtpy fields allowed')),
      );
      return;
    }
    if (LightModeProvider.of(context)
        .bloc
        .lightModeList
        .where((_lightMode) =>
            _lightMode.button == lightMode.button &&
            _lightMode.feedback == lightMode.feedback &&
            _lightMode.path == lightMode.path)
        .isNotEmpty) {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('Button already exists')),
      );
      return;
    }
    RegExp validPath = RegExp(r'^[/]');
    if (validPath.allMatches(lightMode.path).length > 0) {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Type path without "/"')));
      return;
    }
    LightModeProvider.of(context).bloc.addLightMode.add(lightMode);
    Navigator.pop(context);
  }
}
