import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    @required this.textEditingController,
    this.autofocus,
    this.label,
    @required this.focusNode,
    this.onFieldSubmitted,
    this.number,
  });
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final String label;
  final VoidCallback onFieldSubmitted;
  final bool number;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        autofocus: autofocus ?? false,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        textAlign: number ?? false ? TextAlign.center : TextAlign.left,
        keyboardType: number ?? false ? TextInputType.number : TextInputType.text,
        keyboardAppearance: Brightness.dark,
        onFieldSubmitted: (string) => onFieldSubmitted(),
      ),
    );
  }
}
