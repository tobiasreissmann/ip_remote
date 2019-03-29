import 'package:color_remote/bloc/ipAddressProvider.dart';
import 'package:color_remote/gui/ipAddressMask.dart';
import 'package:color_remote/gui/ipAddressCard.dart';
import 'package:flutter/material.dart';

class IpAddressSettings extends StatefulWidget {
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
        IpAddressMask(),
      ],
    );
  }
}

// TODO  /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
