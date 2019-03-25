import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        accentColor: Colors.blue[700],
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Wlads IoT Lampe'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16),
                ),
                ButtonTheme(
                  minWidth: 200,
                  height: 70,
                  buttonColor: Colors.indigo,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    elevation: 9,
                    child: Text(
                      'SwitchBright',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
                    ),
                    onPressed: () => _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              'feedbackMessage',
                            ),
                          ),
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                ),
                ButtonTheme(
                  minWidth: 200,
                  height: 70,
                  buttonColor: Colors.indigo,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    elevation: 9,
                    child: Text(
                      'Ausschalten',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
                    ),
                    onPressed: () => print('Wlad'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                ),
                ButtonTheme(
                  minWidth: 200,
                  height: 70,
                  buttonColor: Colors.indigo,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    elevation: 9,
                    child: Text(
                      'Regenbogen',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
                    ),
                    onPressed: () => print('Wlad'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                ),
                ButtonTheme(
                  minWidth: 200,
                  height: 70,
                  buttonColor: Colors.indigo,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    elevation: 9,
                    child: Text(
                      'Weiß',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
                    ),
                    onPressed: () => print('Wlad'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                ),
                ButtonTheme(
                  minWidth: 200,
                  height: 70,
                  buttonColor: Colors.indigo,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    elevation: 9,
                    child: Text(
                      'Diverses',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
                    ),
                    onPressed: () => print('Wlad'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
