import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:ip_remote/bloc/blocProvider.dart';
import 'package:ip_remote/gui/buttons/buttonSettings.dart';
import 'package:ip_remote/gui/network/ipAddressSettings.dart';
import 'package:ip_remote/gui/remote/remote.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          brightness: Brightness.dark,
          accentColor: Colors.indigo,
        ),
        home: MyHomePage(),
      ),
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
        body: TabBarView(
          dragStartBehavior: DragStartBehavior.down,
          children: <Widget>[
            RemotePage(),
            IpAddressSettings(),
            ButtonSettings(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.settings_remote)),
            Tab(icon: Icon(Icons.settings_input_antenna)),
            Tab(icon: Icon(Icons.edit)),
          ],
          labelColor: Theme.of(context).accentColor,
          unselectedLabelColor: Colors.grey[300],
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Theme.of(context).accentColor,
          dragStartBehavior: DragStartBehavior.down,
        ),
        backgroundColor: Colors.grey[900],
      ),
    );
  }
}
