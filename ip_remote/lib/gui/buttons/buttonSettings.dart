import 'package:flutter/material.dart';
import 'package:dragable_flutter_list/dragable_flutter_list.dart';

import 'package:ip_remote/bloc/blocProvider.dart';
import 'package:ip_remote/gui/buttons/addButtonDialog.dart';
import 'package:ip_remote/gui/buttons/lightModeCard.dart';
import 'package:ip_remote/gui/utils/addButtonSmall.dart';
import 'package:ip_remote/gui/utils/noContentPlaceholder.dart';
import 'package:ip_remote/models/lightMode.dart';

class ButtonSettings extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: BlocProvider.of(context).lightModeBloc.lightModeListStream,
            builder: (BuildContext context, AsyncSnapshot<List<LightMode>> lightModeList) {
              return lightModeList.hasData
                  ? DragAndDropList(
                      lightModeList.data.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (lightModeList.data.isEmpty)
                          return NoContentPlaceholder(placeholderText: 'Add buttons here');
                        if (index == lightModeList.data.length) return SizedBox(height: 70);
                        return LightModeCardItem(lightMode: lightModeList.data[index]);
                      },
                      dragElevation: 4,
                      canBeDraggedTo: (int oldIndex, int newIndex) => true,
                      onDragFinish: (int oldIndex, int newIndex) {
                        if (newIndex >= lightModeList.data.length) newIndex = lightModeList.data.length - 1;
                        BlocProvider.of(context).lightModeBloc.reorderLightModes.add([oldIndex, newIndex]);
                      },
                    )
                  : SizedBox();
            },
          ),
          AddButtonSmall(
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddButtonDialog(), fullscreenDialog: true),
                ),
            heroTag: 'addLightMode',
          ),
        ],
      ),
    );
  }
}
