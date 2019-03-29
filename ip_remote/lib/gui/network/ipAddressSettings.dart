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
                    ? ipAddressList.data.length > 0
                        ? ipAddressList.data.map((ipAddress) => IpAddressCard(ipAddress: ipAddress)).toList()
                        : [NoIpAddressPlaceholder()]
                    : [NoIpAddressPlaceholder()])
                ..addAll([SizedBox(height: 80)]),
            );
          },
        ),
        IpAddressMask(scaffoldKey: widget.scaffoldKey),
      ],
    );
  }
}

class NoIpAddressPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        alignment: Alignment.bottomCenter,
        height: 40,
        child: Text(
          'Add IP-Address here',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
