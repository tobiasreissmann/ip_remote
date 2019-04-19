import 'package:flutter/material.dart';

import 'package:ip_remote/bloc/blocProvider.dart';
import 'package:ip_remote/gui/remote/lightButton.dart';
import 'package:ip_remote/gui/utils/noContentPlaceholder.dart';
import 'package:ip_remote/models/lightMode.dart';

class RemotePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          StreamBuilder<List<LightMode>>(
            stream: BlocProvider.of(context).lightModeBloc.lightModeListStream,
            builder: (BuildContext context, AsyncSnapshot lightModeList) {
              return lightModeList.hasData
                  ? ListView.builder(
                      itemCount: lightModeList.data.isEmpty ? 1 : lightModeList.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (lightModeList.data.isEmpty)
                          return NoContentPlaceholder(placeholderText: 'No buttons configured');
                        return LightButton(
                          lightMode: lightModeList.data[index],
                          scaffoldKey: scaffoldKey,
                        );
                      },
                    )
                  : SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
