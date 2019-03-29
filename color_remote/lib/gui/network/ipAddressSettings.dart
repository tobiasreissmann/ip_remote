import 'package:flutter/material.dart';

import 'package:ip_remote/bloc/ipAddressProvider.dart';
import 'package:ip_remote/gui/network/ipAddressCard.dart';
import 'package:ip_remote/gui/network/ipAddressMask.dart';

class IpAddressSettings extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  IpAddressSettings({Key key, @required this.scaffoldKey}) : super(key: key);

  @override
  _IpAddressSettingsState createState() => _IpAddressSettingsState();
}

class _IpAddressSettingsState extends State<IpAddressSettings> with AutomaticKeepAliveClientMixin<IpAddressSettings> {
  @override
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        StreamBuilder(
          stream: IpAddressProvider.of(context).bloc.ipAddressListStream,
          builder: (BuildContext context, AsyncSnapshot<List<String>> ipAddressList) {
            return ListView(
              children: <Widget>[]
                ..addAll(ipAddressList.hasData
                    ? ipAddressList.data.map((ipAddress) => IpAddressCard(ipAddress: ipAddress)).toList()
                    : <Widget>[SizedBox()])
                ..addAll([SizedBox(height: 60)].toList()),
            );
          },
        ),
        IpAddressMask(scaffoldKey: widget.scaffoldKey),
      ],
    );
  }
}