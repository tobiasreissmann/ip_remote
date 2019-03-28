import 'package:color_remote/bloc/lightModeProvider.dart';
import 'package:color_remote/gui/LightModeCard.dart';
import 'package:color_remote/models/light_mode.dart';
import 'package:flutter/material.dart';

class ButtonSettings extends StatefulWidget {
  @override
  _ButtonSettingsState createState() => _ButtonSettingsState();
}

class _ButtonSettingsState extends State<ButtonSettings> with AutomaticKeepAliveClientMixin<ButtonSettings> {
  @override
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        StreamBuilder(
          stream: LightModeProvider.of(context).bloc.lightModeListStream,
          builder: (BuildContext context, AsyncSnapshot<List<LightMode>> lightModeList) {
            return ListView(
              children: lightModeList.hasData
                  ? lightModeList.data.map((lightMode) => LightModeCard(lightMode: lightMode)).toList()
                  : <Widget>[SizedBox()],
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(flex: 4, child: SizedBox()),
              Expanded(
                child: RaisedButton(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: Icon(Icons.add),
                  onPressed: () => LightModeProvider.of(context).bloc.addLightMode.add(
                        LightMode(
                          'button',
                          'feedback',
                          'string',
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
