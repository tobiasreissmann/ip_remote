import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:ip_remote/gui/utils/AddButtonBig.dart';
import 'package:ip_remote/gui/utils/customTextField.dart';
import 'package:vibrate/vibrate.dart';

import 'package:ip_remote/bloc/blocProvider.dart';
import 'package:ip_remote/models/lightMode.dart';

class AddButtonDialog extends StatefulWidget {
  @override
  _AddButtonDialogState createState() => _AddButtonDialogState();
}

class _AddButtonDialogState extends State<AddButtonDialog> {
  TextEditingController _buttonTextEditingController;
  TextEditingController _feedbackTextEditingController;
  TextEditingController _pathTextEditingController;

  FocusNode _buttonFocusNode;
  FocusNode _feedbackFocusNode;
  FocusNode _pathFocusNode;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Color _buttonColor = Colors.indigo;

  @override
  void initState() {
    _buttonTextEditingController = TextEditingController();
    _feedbackTextEditingController = TextEditingController();
    _pathTextEditingController = TextEditingController();

    _buttonFocusNode = FocusNode();
    _feedbackFocusNode = FocusNode();
    _pathFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _buttonTextEditingController.dispose();
    _feedbackTextEditingController.dispose();
    _pathTextEditingController.dispose();

    _buttonFocusNode.dispose();
    _feedbackFocusNode.dispose();
    _pathFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    updateFocus(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Theme(
        data: Theme.of(context).copyWith(
          accentColor: _buttonColor,
          cursorColor: _buttonColor,
          textSelectionColor: _buttonColor,
        ),
        isMaterialAppTheme: true,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 32),
            CustomTextField(
              label: 'Button Text',
              textEditingController: _buttonTextEditingController,
              focusNode: _buttonFocusNode,
              onFieldSubmitted: () => updateFocus(context),
              number: false,
            ),
            CustomTextField(
              label: 'Feedback Message',
              textEditingController: _feedbackTextEditingController,
              focusNode: _feedbackFocusNode,
              onFieldSubmitted: () => updateFocus(context),
              number: false,
            ),
            CustomTextField(
              label: 'Request Path',
              textEditingController: _pathTextEditingController,
              focusNode: _pathFocusNode,
              onFieldSubmitted: () => updateFocus(context),
              number: false,
            ),
            AddButtonBig(
              onPressed: () => addLightMode(context),
              onLongPress: () => chooseColor(context),
              buttonColor: _buttonColor,
              iconColor:
                  ThemeData.estimateBrightnessForColor(_buttonColor) == Brightness.light ? Colors.black : Colors.white,
              heroTag: 'addLightMode',
            ),
          ],
        ),
      ),
    );
  }

  void updateFocus(BuildContext context) {
    if (_buttonTextEditingController.text.isEmpty) return FocusScope.of(context).requestFocus(_buttonFocusNode);
    if (_feedbackTextEditingController.text.isEmpty) return FocusScope.of(context).requestFocus(_feedbackFocusNode);
    if (_pathTextEditingController.text.isEmpty) return FocusScope.of(context).requestFocus(_pathFocusNode);
    return FocusScope.of(context).detach();
  }

  void chooseColor(BuildContext context) {
    Vibrate.feedback(FeedbackType.selection);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MaterialColorPicker(
          circleSize: 50,
          allowShades: false,
          onMainColorChange: (Color selectedColor) => setState(() => _buttonColor = selectedColor),
          selectedColor: _buttonColor,
        );
      },
    );
  }

  void addLightMode(BuildContext context) {
    updateFocus(context);
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
      _buttonColor,
    );
    if (BlocProvider.of(context)
        .lightModeBloc
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
    BlocProvider.of(context).lightModeBloc.addLightMode.add(lightMode);
    Navigator.pop(context);
  }
}
