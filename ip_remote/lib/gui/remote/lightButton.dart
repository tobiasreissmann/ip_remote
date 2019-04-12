import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ip_remote/bloc/ipAddressProvider.dart';
import 'package:ip_remote/models/ip_address.dart';
import 'package:ip_remote/models/light_mode.dart';

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
    return Column(
      children: <Widget>[
        ButtonTheme(
          minWidth: 200,
          height: 70,
          buttonColor: Colors.indigo,
          child: RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 4,
            child: Text(
              lightMode.button,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            onPressed: () => pushMode(lightMode, context),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
        ),
      ],
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
    IpAddress ipAddress = IpAddressProvider.of(context).bloc.activeIpAddress;
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
