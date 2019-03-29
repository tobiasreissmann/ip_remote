import 'package:color_remote/bloc/lightModeProvider.dart';
import 'package:color_remote/models/light_mode.dart';
import 'package:flutter/material.dart';

class AddButtonDialog extends StatefulWidget {
  @override
  _AddButtonDialogState createState() => _AddButtonDialogState();
}

class _AddButtonDialogState extends State<AddButtonDialog> {
  TextEditingController _button = TextEditingController();
  TextEditingController _feedback = TextEditingController();
  TextEditingController _string = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
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
                      onPressed: () {
                        if (_button.text == '' || _feedback.text == '' || _string.text == '') return;
                        LightModeProvider.of(context).bloc.addLightMode.add(
                              LightMode(
                                _button.text,
                                _feedback.text,
                                _string.text,
                              ),
                            );
                        Navigator.pop(context);
                      },
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
}
