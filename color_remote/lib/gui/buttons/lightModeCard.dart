import 'package:flutter/material.dart';

import 'package:color_remote/bloc/lightModeProvider.dart';
import 'package:color_remote/models/light_mode.dart';

class LightModeCard extends StatelessWidget {
  final LightMode lightMode;

  LightModeCard({Key key, this.lightMode}) : super(key: key);

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
                "/${lightMode.string}",
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
                onPressed: () => LightModeProvider.of(context).bloc.deleteLightMode.add(lightMode),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
