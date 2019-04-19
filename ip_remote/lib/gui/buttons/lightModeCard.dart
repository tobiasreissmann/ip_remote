import 'package:flutter/material.dart';

import 'package:ip_remote/bloc/blocProvider.dart';
import 'package:ip_remote/models/light_mode.dart';

class LightModeCardItem extends StatelessWidget {
  final LightMode lightMode;

  LightModeCardItem({Key key, this.lightMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.all(4),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 16),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    lightMode.button,
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(padding: const EdgeInsets.all(2)),
                  Text(
                    '"${lightMode.feedback}"',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "/${lightMode.path}",
              style: TextStyle(
                fontFamily: 'OxygenMono',
                fontSize: 16,
                color: Colors.indigo[200],
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
