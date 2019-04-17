import 'package:flutter/material.dart';
// import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

import 'package:ip_remote/bloc/blocProvider.dart';
import 'package:ip_remote/models/light_mode.dart';

class LightModeCard extends StatelessWidget {
  final LightMode lightMode;

  LightModeCard({Key key, this.lightMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return ReorderableItem(
    //   key: Key(lightMode.button + lightMode.feedback + lightMode.path),
    //   childBuilder: (BuildContext context, ReorderableItemState state) {
    //     DelayedReorderableListener(
    //       child: Container(
    //         color: state == ReorderableItemState.placeholder ? null : Colors.red,
    //         child: Opacity(
    //           opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
    //           child: IntrinsicHeight(
    //             child: Row(
    //               crossAxisAlignment: CrossAxisAlignment.stretch,
    //               children: <Widget>[
    //                 Expanded(
    //                   child: Padding(
    //                     padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
    //                     child: Text('data.title', style: Theme.of(context).textTheme.subhead),
    //                   ),
    //                 ),
    //               ],
    //             ),
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
