import 'package:flutter/material.dart';

class AddButtonBig extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback onLongPress;
  final String heroTag;
  final Color buttonColor;
  final Color iconColor;

  AddButtonBig({this.onPressed, this.onLongPress, this.buttonColor, this.iconColor, this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: SizedBox(),
          ),
          Expanded(
            flex: 6,
            child: ButtonTheme(
              height: 50,
              child: Hero(
                tag: heroTag,
                child: ButtonTheme(
                  height: 60,
                  minWidth: 90,
                  child: GestureDetector(
                    onLongPress: onLongPress,
                    child: RaisedButton(
                      color: buttonColor,
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Icon(Icons.add, size: 36, color: iconColor),
                      onPressed: onPressed,
                    ),
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
    );
  }
}
