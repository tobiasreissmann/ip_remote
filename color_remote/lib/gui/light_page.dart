import 'package:color_remote/gui/light_button.dart';
import 'package:color_remote/models/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LightPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  LightPage({Key key, this.scaffoldKey}) : super(key: key);

  final LightMode off = LightMode(
    'Ausschalten',
    'Ausgeschaltet',
    'setoff',
  );
  final LightMode bright = LightMode(
    'Helligkeit',
    'Helligkeit geändert',
    'setbright',
  );
  final LightMode rgb = LightMode(
    'RGB',
    'RGB-Modus',
    'setmod1',
  );
  final LightMode white = LightMode(
    'Weiß',
    'Weiß-Modus',
    'setmod2',
  );
  final LightMode rainbow = LightMode(
    'Regenbogen',
    'Regenbogen-Modus',
    'setmod3',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(8)),
              LightButton(
                text: off.button,
                onPressed: () => pushMode(off),
              ),
              LightButton(
                text: bright.button,
                onPressed: () => pushMode(bright),
              ),
              LightButton(
                text: rgb.button,
                onPressed: () => pushMode(rgb),
              ),
              LightButton(
                text: white.button,
                onPressed: () => pushMode(white),
              ),
              LightButton(
                text: rainbow.button,
                onPressed: () => pushMode(rainbow),
              ),
            ],
          )
        ],
      ),
    );
  }

  void pushMode(LightMode mode) async {
    scaffoldKey.currentState.removeCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          mode.feedback,
        ),
      ),
    );
    try {
      await sendRequest(mode.string);
    } catch (error) {
      return null; // dirty error handling because webserver does not send response header
    }
  }

  Future<void> sendRequest(String mode) async {
    await http.get('http://192.168.43.31/$mode');
  }
}
