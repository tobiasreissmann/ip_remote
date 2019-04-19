import 'package:flutter/material.dart';

import 'package:ip_remote/bloc/blocProvider.dart';
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
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        StreamBuilder<List<LightMode>>(
          stream: BlocProvider.of(context).lightModeBloc.lightModeListStream,
          builder: (BuildContext context, AsyncSnapshot lightModeList) {
            return lightModeList.hasData
                ? ListView.builder(
                    itemCount: lightModeList.data.isEmpty ? 1 : lightModeList.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (lightModeList.data.isEmpty) return NoButtonsPlaceholder();
                      return LightButton(
                        lightMode: lightModeList.data[index],
                        scaffoldKey: widget.scaffoldKey,
                      );
                    },
                  )
                : SizedBox();
          },
        ),
      ],
    );
  }
}

class NoButtonsPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        alignment: Alignment.bottomCenter,
        height: 40,
        child: Text(
          'No buttons configured',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
