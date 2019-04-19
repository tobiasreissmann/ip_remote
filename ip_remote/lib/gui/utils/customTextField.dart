import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({this.textEditingController, this.label, this.focusNode, this.onFieldSubmitted, this.number});
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final String label;
  final VoidCallback onFieldSubmitted;
  final bool number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        textAlign: number ? TextAlign.center : TextAlign.left,
        keyboardType: number ? TextInputType.number : TextInputType.text,
        keyboardAppearance: Brightness.dark,
        onFieldSubmitted: (string) => onFieldSubmitted(),
      ),
    );
  }
}
