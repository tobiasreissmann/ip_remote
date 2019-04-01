import 'package:flutter/material.dart';

import 'package:ip_remote/bloc/ipAddressProvider.dart';
import 'package:ip_remote/models/ip_address.dart';

class AddIpAddressDialog extends StatefulWidget {
  @override
  _AddIpAddressDialogState createState() => _AddIpAddressDialogState();
}

class _AddIpAddressDialogState extends State<AddIpAddressDialog> {
  final TextEditingController _ipA = TextEditingController();
  final TextEditingController _ipB = TextEditingController();
  final TextEditingController _ipC = TextEditingController();
  final TextEditingController _ipD = TextEditingController();

  TextEditingController _desciption = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        key: _scaffoldKey,
        body: ListView(
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(16)),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                keyboardAppearance: Brightness.dark,
                controller: _desciption,
                decoration: InputDecoration(
                  labelText: 'Description Text',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _ipA,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Text('.', style: TextStyle(fontWeight: FontWeight.bold)),
                        Expanded(
                          child: TextFormField(
                            controller: _ipB,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Text('.', style: TextStyle(fontWeight: FontWeight.bold)),
                        Expanded(
                          child: TextFormField(
                            controller: _ipC,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Text('.', style: TextStyle(fontWeight: FontWeight.bold)),
                        Expanded(
                          child: TextFormField(
                            controller: _ipD,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(padding: const EdgeInsets.all(4)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
              child: ButtonTheme(
                height: 50,
                child: Hero(
                  tag: "addIpAddress",
                  child: ButtonTheme(
                    height: 60,
                    minWidth: 90,
                    child: RaisedButton(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Icon(Icons.add, size: 36),
                      onPressed: () => addIpAddress(context),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addIpAddress(BuildContext context) {
    if (_ipA.text == '' || _ipB.text == '' || _ipB.text == '' || _ipB.text == '') {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('No empty fields allowed')),
      );
      return;
    }
    final IpAddress ipAddress = IpAddress('${_ipA.text}.${_ipB.text}.${_ipC.text}.${_ipD.text}', _desciption.text);
    RegExp validIpAddress =
        RegExp(r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
    if (validIpAddress.allMatches(ipAddress.address).length != 1) {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('False IP-Address syntax')),
      );
      return;
    }
    if (IpAddressProvider.of(context)
        .bloc
        .ipAddressList
        .where(
            (_ipAddress) => _ipAddress.address == ipAddress.address && _ipAddress.description == ipAddress.description)
        .isNotEmpty) {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('IP-Address already exists')),
      );
      return;
    }
    IpAddressProvider.of(context).bloc.addIpAddress.add(ipAddress);
    _ipA.clear();
    _ipB.clear();
    _ipC.clear();
    _ipD.clear();
    _desciption.clear();
    Navigator.pop(context);
  }
}
