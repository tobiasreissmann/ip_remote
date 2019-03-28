import 'package:color_remote/bloc/ipAddressProvider.dart';
import 'package:color_remote/gui/lightButton.dart';
import 'package:color_remote/models/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RemotePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  RemotePage({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _RemotePageState createState() => _RemotePageState();
}

class _RemotePageState extends State<RemotePage> with AutomaticKeepAliveClientMixin<RemotePage> {
  final LightMode off = LightMode('Ausschalten', 'Ausgeschaltet', 'setoff');
  final LightMode bright = LightMode('Helligkeit', 'Helligkeit geändert', 'setbright');
  final LightMode rgb = LightMode('RGB', 'RGB-Modus', 'setmod1');
  final LightMode white = LightMode('Weiß', 'Weiß-Modus', 'setmod2');
  final LightMode rainbow = LightMode('Regenbogen', 'Regenbogen-Modus', 'setmod3');

  @override
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: const EdgeInsets.all(8)),
              LightButton(
                text: off.button,
                onPressed: () => pushMode(off, context),
              ),
              LightButton(
                text: bright.button,
                onPressed: () => pushMode(bright, context),
              ),
              LightButton(
                text: rgb.button,
                onPressed: () => pushMode(rgb, context),
              ),
              LightButton(
                text: white.button,
                onPressed: () => pushMode(white, context),
              ),
              LightButton(
                text: rainbow.button,
                onPressed: () => pushMode(rainbow, context),
              ),
            ],
          )
        ],
      ),
    );
  }

  void pushMode(LightMode mode, BuildContext context) async {
    widget.scaffoldKey.currentState.removeCurrentSnackBar();
    widget.scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          mode.feedback,
        ),
      ),
    );
    try {
      await sendRequest(mode.string, context);
    } catch (error) {
      return null; // dirty error handling because webserver does not send response header
    }
  }

  Future<void> sendRequest(String mode, BuildContext context) async {
    await http.get('http://${IpAddressProvider.of(context).activeIpAddress}/$mode'); // TODO test the variable IpAddress
  }
}
