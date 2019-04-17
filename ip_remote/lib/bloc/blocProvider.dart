import 'package:flutter/material.dart';

import 'package:ip_remote/bloc/lightModeBloc.dart';
import 'package:ip_remote/bloc/ipAddressBloc.dart';

class BlocProvider extends InheritedWidget {
  BlocProvider({Key key, this.child}) : super(key: key, child: child);

  final Widget child;

  final lightModeBloc = LightModeBloc();
  final ipAddressBloc = IpAddressBloc();

  static BlocProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider);
  }

  @override
  bool updateShouldNotify(BlocProvider oldWidget) {
    return true;
  }
}
