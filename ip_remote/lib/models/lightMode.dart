import 'package:flutter/material.dart';

class LightMode {
  final String button;
  final String feedback;
  final String path;
  final Color buttonColor;
  Key key;

  LightMode(this.button, this.feedback, this.path, this.buttonColor) {
    this.key = Key(button + feedback + path);
  }
}
