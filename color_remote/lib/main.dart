import 'package:color_remote/bloc/ipAddressProvider.dart';
import 'package:color_remote/bloc/lightModeProvider.dart';
import 'package:color_remote/gui/buttonSettings.dart';
import 'package:color_remote/gui/remote.dart';
import 'package:color_remote/gui/ipAddressSettings.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
        accentColor: Colors.indigo,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('IP-Remote'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.lightbulb_outline)),
              Tab(icon: Icon(Icons.import_export)),
              Tab(icon: Icon(Icons.settings)),
            ],
          ),
        ),
        body: LightModeProvider(
          child: IpAddressProvider(
            child: TabBarView(
              children: <Widget>[
                RemotePage(scaffoldKey: _scaffoldKey),
                IpAddressSettings(),
                ButtonSettings(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
