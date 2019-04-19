import 'package:flutter/material.dart';

import 'package:ip_remote/bloc/blocProvider.dart';
import 'package:ip_remote/models/ip_address.dart';

class IpAddressCard extends StatelessWidget {
  IpAddressCard({@required this.ipAddress});
  final IpAddress ipAddress;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      ipAddress.description,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 4),
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
            ),
            StreamBuilder<Object>(
              stream: BlocProvider.of(context).ipAddressBloc.activeIpAddressStream,
              builder: (BuildContext context, AsyncSnapshot activeIpAdress) {
                return IconButton(
                  icon: Icon(
                    Icons.check_circle,
                  ),
                  color: activeIpAdress.hasData
                      ? activeIpAdress.data.address == ipAddress.address ? Colors.green : Colors.white
                      : Colors.white,
                  onPressed: () => BlocProvider.of(context).ipAddressBloc.changeActiveIpAddress.add(ipAddress),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.remove_circle,
              ),
              color: Colors.red[700],
              onPressed: () => BlocProvider.of(context).ipAddressBloc.deleteIpAddress.add(ipAddress),
            ),
          ],
        ),
      ),
    );
  }
}
