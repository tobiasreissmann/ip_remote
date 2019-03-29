import 'package:flutter/material.dart';

import 'package:ip_remote/bloc/lightModeProvider.dart';
import 'package:ip_remote/gui/buttons/addButtonDialog.dart';
import 'package:ip_remote/gui/buttons/LightModeCard.dart';
import 'package:ip_remote/models/light_mode.dart';

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
                children: <Widget>[]
                  ..addAll(lightModeList.hasData
                      ? lightModeList.data.length > 0
                          ? lightModeList.data.map((lightMode) => LightModeCard(lightMode: lightMode)).toList()
                          : [NoButtonsPlaceholder()]
                      : [NoButtonsPlaceholder()])
                  ..addAll([SizedBox(height: 80)]));
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(flex: 4, child: SizedBox()),
              Hero(
                tag: "addButton",
                child: ButtonTheme(
                  height: 40,
                  minWidth: 60,
                  child: RaisedButton(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.add),
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddButtonDialog()),
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

class NoButtonsPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        alignment: Alignment.bottomCenter,
        height: 40,
        child: Text(
          'Add buttons here',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
