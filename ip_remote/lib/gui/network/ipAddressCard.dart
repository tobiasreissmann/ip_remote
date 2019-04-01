import 'package:flutter/material.dart';

import 'package:ip_remote/bloc/ipAddressProvider.dart';
import 'package:ip_remote/models/ip_address.dart';

class IpAddressCard extends StatelessWidget {
  IpAddressCard({@required this.ipAddress});
  final IpAddress ipAddress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      ipAddress.description,
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(padding: const EdgeInsets.all(2)),
                    Text(
                      ipAddress.address,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
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
                        ? activeIpAdress.data.address == ipAddress.address ? Colors.green : Colors.white
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
