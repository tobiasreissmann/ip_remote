import 'package:color_remote/bloc/ipAddressProvider.dart';
import 'package:color_remote/gui/ipAddressMask.dart';
import 'package:color_remote/gui/ipAddress.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        StreamBuilder(
          stream: IpAddressProvider.of(context).bloc.ipAddressListStream,
          builder: (BuildContext context, AsyncSnapshot<List<String>> ipAddressList) {
            return ListView(
              children: ipAddressList.hasData
                  ? ipAddressList.data.map((ipAddress) => IpAddress(ipAddress: ipAddress)).toList()
                  : <Widget>[SizedBox()],
            );
          },
        ),
        IpAddressMask(),
      ],
    );
  }
}

// /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
