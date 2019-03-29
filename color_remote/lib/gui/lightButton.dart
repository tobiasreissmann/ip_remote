import 'package:color_remote/models/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:color_remote/bloc/ipAddressProvider.dart';

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
      await sendRequest(lightMode.string, context);
    } catch (error) {
      print(error.toString());
      return null; // dirty error handling because webserver does not send response header
    }
  }

  Future<void> sendRequest(String path, BuildContext context) async {
    String ipAddress = IpAddressProvider.of(context).bloc.activeIpAddress;
    if (ipAddress == '') {
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
    await http.get('http://$ipAddress/$path'); // TODO test the variable IpAddress
  }
}
