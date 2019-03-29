import 'package:flutter/material.dart';

import 'package:ip_remote/bloc/ipAddressProvider.dart';

class IpAddressMask extends StatelessWidget {
  final TextEditingController _ipA = TextEditingController();
  final TextEditingController _ipB = TextEditingController();
  final TextEditingController _ipC = TextEditingController();
  final TextEditingController _ipD = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey;

  IpAddressMask({Key key, @required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: _ipA,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Text('.', style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(
                  child: TextFormField(
                    controller: _ipB,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Text('.', style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(
                  child: TextFormField(
                    controller: _ipC,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Text('.', style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(
                  child: TextFormField(
                    controller: _ipD,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(padding: const EdgeInsets.all(4)),
              ],
            ),
          ),
          ButtonTheme(
            height: 40,
            minWidth: 60,
            child: RaisedButton(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.add),
              onPressed: () => addIpAddress(context),
            ),
          ),
        ],
      ),
    );
  }

  void addIpAddress(BuildContext context) {
    if (_ipA.text == '' || _ipB.text == '' || _ipB.text == '' || _ipB.text == '') {
      scaffoldKey.currentState.removeCurrentSnackBar();
      scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('No empty fields allowed')),
      );
      return;
    }
    final String ipAddress = '${_ipA.text}.${_ipB.text}.${_ipC.text}.${_ipD.text}';
    RegExp validIpAddress =
        RegExp(r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)');
    if (validIpAddress.allMatches(ipAddress).length != 1) {
      scaffoldKey.currentState.removeCurrentSnackBar();
      scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('False IP-Address syntax')),
      );
      return;
    }
    if (IpAddressProvider.of(context).bloc.ipAddressList.where((_ipAddress) => _ipAddress == ipAddress).isNotEmpty) {
      scaffoldKey.currentState.removeCurrentSnackBar();
      scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('IP-Address already exists')),
      );
      return;
    }
    IpAddressProvider.of(context).bloc.addIpAddress.add(ipAddress);
    _ipA.clear();
    _ipB.clear();
    _ipC.clear();
    _ipD.clear();
  }
}
