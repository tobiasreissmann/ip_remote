import 'package:flutter/material.dart';

class NoContentPlaceholder extends StatelessWidget {
  final String placeholderText;
  NoContentPlaceholder({@required this.placeholderText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        alignment: Alignment.bottomCenter,
        height: 40,
        child: Text(
          placeholderText,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.grey,
          )
        ),
      ),
    );
  }
}
