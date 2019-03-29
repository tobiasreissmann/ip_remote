import 'package:flutter/material.dart';

import 'package:color_remote/bloc/ipAddressProvider.dart';

class IpAddressCard extends StatelessWidget {
  IpAddressCard({@required this.ipAddress});
  final String ipAddress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  ipAddress,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              StreamBuilder<Object>(
                stream: IpAddressProvider.of(context).bloc.activeIpAddressStream,
                builder: (BuildContext context, AsyncSnapshot activeIpAdress) {
                  return IconButton(
                    icon: Icon(
                      Icons.check_circle,
                    ),
                    color: activeIpAdress.hasData
                        ? activeIpAdress.data == ipAddress ? Colors.green : Colors.white
                        : Colors.white,
                    onPressed: () => IpAddressProvider.of(context).bloc.changeActiveIpAddress.add(ipAddress),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.remove_circle,
                ),
                color: Colors.red[700],
                onPressed: () => IpAddressProvider.of(context).bloc.deleteIpAddress.add(ipAddress),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
