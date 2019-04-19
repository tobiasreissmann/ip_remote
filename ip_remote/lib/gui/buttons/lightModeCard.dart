import 'package:flutter/material.dart';

import 'package:ip_remote/bloc/blocProvider.dart';
import 'package:ip_remote/models/lightMode.dart';

class LightModeCardItem extends StatelessWidget {
  final LightMode lightMode;

  LightModeCardItem({Key key, this.lightMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: lightMode.buttonColor ?? 0xff3f51b5,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      lightMode.button,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '"${lightMode.feedback}"',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                child: Text(
                  "/${lightMode.path}",
                  style: TextStyle(
                    fontFamily: 'OxygenMono',
                    fontSize: 16,
                    color: Color.lerp(lightMode.buttonColor, Colors.white, 0.4),
                  ),
                ),
                constraints: BoxConstraints(maxWidth: 120),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.remove_circle,
                color: Colors.red[700],
              ),
              onPressed: () => BlocProvider.of(context).lightModeBloc.deleteLightMode.add(lightMode),
            ),
          ],
        ),
      ),
    );
  }
}
