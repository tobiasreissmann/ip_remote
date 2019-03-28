import 'package:color_remote/bloc/lightModeBloc.dart';
import 'package:flutter/material.dart';

class LightModeProvider extends InheritedWidget {
  LightModeProvider({Key key, this.child}) : super(key: key, child: child);

  final Widget child;

  final bloc = LightModeBloc();

  static LightModeProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(LightModeProvider) as LightModeProvider);
  }

  @override
  bool updateShouldNotify(LightModeProvider oldWidget) {
    return true;
  }
}
