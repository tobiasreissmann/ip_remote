import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import 'package:ip_remote/bloc/lightModeProvider.dart';
import 'package:ip_remote/models/light_mode.dart';

class AddButtonDialog extends StatefulWidget {
  @override
  _AddButtonDialogState createState() => _AddButtonDialogState();
}

class _AddButtonDialogState extends State<AddButtonDialog> {
  TextEditingController _buttonTextEditingController = TextEditingController();
  TextEditingController _feedbackTextEditingController = TextEditingController();
  TextEditingController _pathTextEditingController = TextEditingController();

  FocusNode _buttonFocusNode = FocusNode();
  FocusNode _feedbackFocusNode = FocusNode();
  FocusNode _pathFocusNode = FocusNode();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Color buttonColor = Colors.indigo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        key: _scaffoldKey,
        body: ListView(
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(16)),
            _LightTextField(
              label: 'Button Text',
              textEditingController: _buttonTextEditingController,
              focusNode: _buttonFocusNode,
              onFieldSubmitted: () => changeFocus(),
            ),
            _LightTextField(
              label: 'Feedback Message',
              textEditingController: _feedbackTextEditingController,
              focusNode: _feedbackFocusNode,
              onFieldSubmitted: () => changeFocus(),
            ),
            _LightTextField(
              label: 'Request Path',
              textEditingController: _pathTextEditingController,
              focusNode: _pathFocusNode,
              onFieldSubmitted: () => changeFocus(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: IconButton(
                      icon: Icon(
                        Icons.color_lens,
                        size: 30,
                        color: Theme.of(context).disabledColor,
                      ),
                      onPressed: () => chooseColor(context),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: ButtonTheme(
                      height: 50,
                      child: Hero(
                        tag: "addButton",
                        child: ButtonTheme(
                          height: 60,
                          minWidth: 90,
                          child: RaisedButton(
                            color: buttonColor,
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            child: Icon(Icons.add, size: 36),
                            onPressed: () => addLightMode(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeFocus() {
    if (_buttonTextEditingController.text.isEmpty) return FocusScope.of(context).requestFocus(_buttonFocusNode);
    if (_feedbackTextEditingController.text.isEmpty) return FocusScope.of(context).requestFocus(_feedbackFocusNode);
    if (_pathTextEditingController.text.isEmpty) return FocusScope.of(context).requestFocus(_pathFocusNode);
  }

  void chooseColor(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MaterialColorPicker(
          circleSize: 50,
          allowShades: false,
          onMainColorChange: (Color selectedColor) => setState(() => buttonColor = selectedColor),
          selectedColor: buttonColor,
        );
      },
    );
  }

  void addLightMode(BuildContext context) {
    changeFocus();
    if (_buttonTextEditingController.text.isEmpty ||
        _feedbackTextEditingController.text.isEmpty ||
        _pathTextEditingController.text.isEmpty) {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('No emtpy fields allowed')),
      );
      return;
    }
    final LightMode lightMode = LightMode(
      _buttonTextEditingController.text,
      _feedbackTextEditingController.text,
      _pathTextEditingController.text,
      buttonColor.toString().substring(37,45),
    );
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

class _LightTextField extends StatelessWidget {
  _LightTextField({this.textEditingController, this.label, this.focusNode, this.onFieldSubmitted});
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final String label;
  final VoidCallback onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        keyboardAppearance: Brightness.dark,
        controller: textEditingController,
        focusNode: focusNode,
        onFieldSubmitted: (string) => onFieldSubmitted(),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
