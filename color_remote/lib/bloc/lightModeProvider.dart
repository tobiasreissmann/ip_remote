import 'package:flutter/material.dart';

import 'package:ip_remote/bloc/lightModeBloc.dart';

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
