import 'package:flutter/material.dart';
import 'package:color_remote/bloc/ipAddressProvider.dart';

class IpAddressMask extends StatelessWidget {
  final TextEditingController _ipA = TextEditingController();
  final TextEditingController _ipB = TextEditingController();
  final TextEditingController _ipC = TextEditingController();
  final TextEditingController _ipD = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: _ipA,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
          ),
          Text('.'),
          Expanded(
            child: TextFormField(
              controller: _ipB,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
          ),
          Text('.'),
          Expanded(
            child: TextFormField(
              controller: _ipC,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
          ),
          Text('.'),
          Expanded(
            child: TextFormField(
              controller: _ipD,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(padding: const EdgeInsets.all(8)),
          Expanded(
            child: RaisedButton(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.add),
              onPressed: () {
                final String ipAddress = '${_ipA.text}.${_ipB.text}.${_ipC.text}.${_ipD.text}';
                IpAddressProvider.of(context).bloc.addIpAddress.add(ipAddress);
                _ipA.clear();
                _ipB.clear();
                _ipC.clear();
                _ipD.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
