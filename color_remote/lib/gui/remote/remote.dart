import 'package:flutter/material.dart';

import 'package:ip_remote/bloc/lightModeProvider.dart';
import 'package:ip_remote/gui/remote/lightButton.dart';
import 'package:ip_remote/models/light_mode.dart';

class RemotePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  RemotePage({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _RemotePageState createState() => _RemotePageState();
}

class _RemotePageState extends State<RemotePage> with AutomaticKeepAliveClientMixin<RemotePage> {
  @override
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      child: StreamBuilder<List<LightMode>>(
        stream: LightModeProvider.of(context).bloc.lightModeListStream,
        builder: (BuildContext context, AsyncSnapshot lightModeList) {
          return ListView(
            children: <Widget>[Padding(padding: const EdgeInsets.all(8))]..addAll(
                lightModeList.hasData
                    ? lightModeList.data.length > 0
                        ? lightModeList.data.map<Widget>(
                            (lightMode) => LightButton(
                                  lightMode: lightMode,
                                  scaffoldKey: widget.scaffoldKey,
                                ),
                          )
                        : [NoButtonsPlaceholder()]
                    : [NoButtonsPlaceholder()],
              ),
          );
        },
      ),
    );
  }
}

class NoButtonsPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 40,
      child: Text(
        'No buttons configured',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.grey,
        ),
      ),
    );
  }
}
