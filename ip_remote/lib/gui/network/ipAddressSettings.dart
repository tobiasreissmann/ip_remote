import 'package:flutter/material.dart';

import 'package:ip_remote/bloc/blocProvider.dart';
import 'package:ip_remote/gui/network/addIpAddressDialog.dart';
import 'package:ip_remote/gui/network/ipAddressCard.dart';
import 'package:ip_remote/models/ip_address.dart';

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
          stream: BlocProvider.of(context).ipAddressBloc.ipAddressListStream,
          builder: (BuildContext context, AsyncSnapshot<List<IpAddress>> ipAddressList) {
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
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(flex: 4, child: SizedBox()),
              Hero(
                tag: "addIpAddress",
                child: ButtonTheme(
                  height: 40,
                  minWidth: 60,
                  child: RaisedButton(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.add),
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddIpAddressDialog()),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
