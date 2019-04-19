import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ip_remote/bloc/blocProvider.dart';
import 'package:ip_remote/models/ipAddress.dart';
import 'package:ip_remote/models/lightMode.dart';

class LightButton extends StatelessWidget {
  final LightMode lightMode;
  final GlobalKey<ScaffoldState> scaffoldKey;

  LightButton({
    Key key,
    @required this.lightMode,
    @required this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          ButtonTheme(
            minWidth: 200,
            height: 70,
            child: RaisedButton(
              color: lightMode.buttonColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 4,
              child: Text(
                lightMode.button,
                style: TextStyle(
                  color: ThemeData.estimateBrightnessForColor(lightMode.buttonColor) == Brightness.light
                      ? Colors.black
                      : Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () => pushMode(lightMode, context),
            ),
          ),
        ],
      ),
    );
  }

  void pushMode(LightMode lightMode, BuildContext context) async {
    try {
      await sendRequest(lightMode.path, context);
    } catch (error) {
      print(error);
    }
  }

  Future<void> sendRequest(String path, BuildContext context) async {
    IpAddress ipAddress = BlocProvider.of(context).ipAddressBloc.activeIpAddress;
    if (ipAddress == null) {
      scaffoldKey.currentState.removeCurrentSnackBar();
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            'No IP-Address configured / activated',
          ),
        ),
      );
      return;
    }
    scaffoldKey.currentState.removeCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          lightMode.feedback,
        ),
      ),
    );
    await http.post('http://${ipAddress.address}/$path');
  }
}
