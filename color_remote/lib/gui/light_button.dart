import 'package:flutter/material.dart';

class LightButton extends StatelessWidget {
  final Widget child;
  final String text;
  final VoidCallback onPressed;

  LightButton({
    Key key,
    this.child,
    this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ButtonTheme(
          minWidth: 200,
          height: 70,
          buttonColor: Colors.indigo,
          child: RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 4,
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
            ),
            onPressed: onPressed,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
        ),
      ],
    );
  }
}
