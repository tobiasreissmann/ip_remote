import 'package:flutter/material.dart';

import 'package:ip_remote/bloc/blocProvider.dart';
import 'package:ip_remote/gui/utils/AddButtonBig.dart';
import 'package:ip_remote/gui/utils/customTextField.dart';
import 'package:ip_remote/models/ipAddress.dart';

class AddIpAddressDialog extends StatefulWidget {
  @override
  _AddIpAddressDialogState createState() => _AddIpAddressDialogState();
}

class _AddIpAddressDialogState extends State<AddIpAddressDialog> {
  TextEditingController _descriptonTextEditingController;
  TextEditingController _ipBTextEditingController;
  TextEditingController _ipATextEditingController;
  TextEditingController _ipCTextEditingController;
  TextEditingController _ipDTextEditingController;

  FocusNode _descriptionFocusNode;
  FocusNode _ipAFocusNode;
  FocusNode _ipBFocusNode;
  FocusNode _ipCFocusNode;
  FocusNode _ipDFocusNode;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _descriptonTextEditingController = TextEditingController();
    _ipATextEditingController = TextEditingController();
    _ipBTextEditingController = TextEditingController();
    _ipCTextEditingController = TextEditingController();
    _ipDTextEditingController = TextEditingController();

    _descriptionFocusNode = FocusNode();
    _ipAFocusNode = FocusNode();
    _ipBFocusNode = FocusNode();
    _ipCFocusNode = FocusNode();
    _ipDFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _descriptonTextEditingController.dispose();
    _ipATextEditingController.dispose();
    _ipBTextEditingController.dispose();
    _ipCTextEditingController.dispose();
    _ipDTextEditingController.dispose();

    _descriptionFocusNode.dispose();
    _ipAFocusNode.dispose();
    _ipBFocusNode.dispose();
    _ipCFocusNode.dispose();
    _ipDFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 32),
            CustomTextField(
              focusNode: _descriptionFocusNode,
              textEditingController: _descriptonTextEditingController,
              onFieldSubmitted: () => updateFocus(context),
              label: 'Description text',
              autofocus: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: CustomTextField(
                      focusNode: _ipAFocusNode,
                      textEditingController: _ipATextEditingController,
                      onFieldSubmitted: () => updateFocus(context),
                      label: '',
                      number: true,
                    ),
                  ),
                  Text('.', style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(
                    child: CustomTextField(
                      focusNode: _ipBFocusNode,
                      textEditingController: _ipBTextEditingController,
                      onFieldSubmitted: () => updateFocus(context),
                      label: '',
                      number: true,
                    ),
                  ),
                  Text('.', style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(
                    child: CustomTextField(
                      focusNode: _ipCFocusNode,
                      textEditingController: _ipCTextEditingController,
                      onFieldSubmitted: () => updateFocus(context),
                      label: '',
                      number: true,
                    ),
                  ),
                  Text('.', style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(
                    child: CustomTextField(
                      focusNode: _ipDFocusNode,
                      textEditingController: _ipDTextEditingController,
                      onFieldSubmitted: () => updateFocus(context),
                      label: '',
                      number: true,
                    ),
                  ),
                ],
              ),
            ),
            AddButtonBig(
              onPressed: () => addIpAddress(context),
              buttonColor: Theme.of(context).accentColor,
              iconColor: Colors.white,
              heroTag: 'addIpAddress',
            ),
          ],
        ),
      ),
    );
  }

  void updateFocus(BuildContext context) {
    if (_descriptonTextEditingController.text.isEmpty)
      return FocusScope.of(context).requestFocus(_descriptionFocusNode);
    if (_ipATextEditingController.text.isEmpty) return FocusScope.of(context).requestFocus(_ipAFocusNode);
    if (_ipBTextEditingController.text.isEmpty) return FocusScope.of(context).requestFocus(_ipBFocusNode);
    if (_ipCTextEditingController.text.isEmpty) return FocusScope.of(context).requestFocus(_ipCFocusNode);
    if (_ipDTextEditingController.text.isEmpty) return FocusScope.of(context).requestFocus(_ipDFocusNode);
    return FocusScope.of(context).detach();
  }

  void addIpAddress(BuildContext context) {
    updateFocus(context);
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
      _descriptonTextEditingController.text != '' ? _descriptonTextEditingController.text : 'IP-Address',
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
    _descriptonTextEditingController.clear();
    Navigator.pop(context);
  }
}
