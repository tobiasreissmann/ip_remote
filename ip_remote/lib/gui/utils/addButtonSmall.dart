import 'package:flutter/material.dart';

class AddButtonSmall extends StatelessWidget {
  final VoidCallback onPressed;
  final String heroTag;

  AddButtonSmall({@required this.onPressed, this.heroTag = 'noTag'});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(flex: 4, child: SizedBox()),
              Hero(
                tag: heroTag,
                child: ButtonTheme(
                  height: 40,
                  minWidth: 60,
                  child: RaisedButton(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.add),
                    onPressed: onPressed,
                  ),
                ),
              ),
            ],
          ),
        );
  }
}