import 'package:flutter/material.dart';

import 'package:ip_remote/bloc/blocProvider.dart';
import 'package:ip_remote/models/ip_address.dart';

class AddIpAddressDialog extends StatefulWidget {
  @override
  _AddIpAddressDialogState createState() => _AddIpAddressDialogState();
}

class _AddIpAddressDialogState extends State<AddIpAddressDialog> {
  final TextEditingController _ipATextEditingController = TextEditingController();
  final TextEditingController _ipBTextEditingController = TextEditingController();
  final TextEditingController _ipCTextEditingController = TextEditingController();
  final TextEditingController _ipDTextEditingController = TextEditingController();

  final FocusNode _ipAFocusNode = FocusNode();
  final FocusNode _ipBFocusNode = FocusNode();
  final FocusNode _ipCFocusNode = FocusNode();
  final FocusNode _ipDFocusNode = FocusNode();

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
                        IpField(
                          focusNode: _ipAFocusNode,
                          textEditingController: _ipATextEditingController,
                          onFieldSubmitted: () => changeFocus(),
                        ),
                        Text('.', style: TextStyle(fontWeight: FontWeight.bold)),
                        IpField(
                          focusNode: _ipBFocusNode,
                          textEditingController: _ipBTextEditingController,
                          onFieldSubmitted: () => changeFocus(),
                        ),
                        Text('.', style: TextStyle(fontWeight: FontWeight.bold)),
                        IpField(
                          focusNode: _ipCFocusNode,
                          textEditingController: _ipCTextEditingController,
                          onFieldSubmitted: () => changeFocus(),
                        ),
                        Text('.', style: TextStyle(fontWeight: FontWeight.bold)),
                        IpField(
                          focusNode: _ipDFocusNode,
                          textEditingController: _ipDTextEditingController,
                          onFieldSubmitted: () => changeFocus(),
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

  void changeFocus() {
    if (_ipATextEditingController.text.isEmpty) return FocusScope.of(context).requestFocus(_ipAFocusNode);
    if (_ipBTextEditingController.text.isEmpty) return FocusScope.of(context).requestFocus(_ipBFocusNode);
    if (_ipCTextEditingController.text.isEmpty) return FocusScope.of(context).requestFocus(_ipCFocusNode);
    if (_ipDTextEditingController.text.isEmpty) return FocusScope.of(context).requestFocus(_ipDFocusNode);
  }

  void addIpAddress(BuildContext context) {
    changeFocus();
    if (_ipATextEditingController.text.isEmpty ||
        _ipBTextEditingController.text.isEmpty ||
        _ipBTextEditingController.text.isEmpty ||
        _ipBTextEditingController.text.isEmpty) {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('The IP-Address is incomplete.')),
      );
      return;
    }
    final IpAddress ipAddress = IpAddress(
      '${_ipATextEditingController.text}.${_ipBTextEditingController.text}.${_ipCTextEditingController.text}.${_ipDTextEditingController.text}',
      _desciption.text != '' ? _desciption.text : 'IP-Address',
    );
    RegExp validIpAddress =
        RegExp(r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
    if (validIpAddress.allMatches(ipAddress.address).length != 1) {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('False IP-Address syntax')),
      );
      return;
    }
    if (BlocProvider.of(context)
        .ipAddressBloc
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
    BlocProvider.of(context).ipAddressBloc.addIpAddress.add(ipAddress);
    _ipATextEditingController.clear();
    _ipBTextEditingController.clear();
    _ipCTextEditingController.clear();
    _ipDTextEditingController.clear();
    _desciption.clear();
    Navigator.pop(context);
  }
}

class IpField extends StatelessWidget {
  IpField({this.textEditingController, this.focusNode, this.onFieldSubmitted});
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final VoidCallback onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        onFieldSubmitted: (string) => onFieldSubmitted(),
      ),
    );
  }
}
