import 'package:color_remote/light_button.dart';
import 'package:flutter/material.dart';

class LightPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  LightPage({Key key, this.scaffoldKey}) : super(key: key);

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
                text: 'Ausschalten',
                onPressed: () => showSnack('Ausgeschaltet'),
              ),
              LightButton(
                text: 'Helligkeit',
                onPressed: () => showSnack('Helligkeit geändert'),
              ),
              LightButton(
                text: 'RGB',
                onPressed: () => showSnack('RGB-Modus'),
              ),
              LightButton(
                text: 'Weiß',
                onPressed: () => showSnack('Weiß-Modus'),
              ),
              LightButton(
                text: 'Regenbogen',
                onPressed: () => showSnack('Regenbogen-Modus'),
              ),
            ],
          )
        ],
      ),
    );
  }

  void showSnack(String text) {
    scaffoldKey.currentState.removeCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          text,
        ),
      ),
    );
  }
}
