import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  buttonColor: Colors.blue[200],
                  child: RaisedButton(
                    child: Text(
                      'SwitchBright',
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
                  buttonColor: Colors.blue[200],
                  child: RaisedButton(
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
                  buttonColor: Colors.blue[200],
                  child: RaisedButton(
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
                  buttonColor: Colors.blue[200],
                  child: RaisedButton(
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
                  buttonColor: Colors.blue[200],
                  child: RaisedButton(
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
