import 'package:flutter/material.dart';
import 'package:dragable_flutter_list/dragable_flutter_list.dart';

import 'package:ip_remote/bloc/blocProvider.dart';
import 'package:ip_remote/gui/buttons/addButtonDialog.dart';
import 'package:ip_remote/gui/buttons/lightModeCard.dart';
import 'package:ip_remote/models/light_mode.dart';

class ButtonSettings extends StatefulWidget {
  @override
  _ButtonSettingsState createState() => _ButtonSettingsState();
}

class _ButtonSettingsState extends State<ButtonSettings> with AutomaticKeepAliveClientMixin<ButtonSettings> {
  @override
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        StreamBuilder(
          stream: BlocProvider.of(context).lightModeBloc.lightModeListStream,
          builder: (BuildContext context, AsyncSnapshot<List<LightMode>> lightModeList) {
            return lightModeList.hasData
                ? DragAndDropList(
                    lightModeList.data.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (lightModeList.data.isEmpty) return NoButtonsPlaceholder();
                      if (index == lightModeList.data.length) return SizedBox(height:60);
                      return LightModeCardItem(lightMode: lightModeList.data[index]);
                    },
                    dragElevation: 4,
                    canBeDraggedTo: (int oldIndex, int newIndex) => true,
                    onDragFinish: (int oldIndex, int newIndex) {
                      BlocProvider.of(context).lightModeBloc.reorderLightModes.add([oldIndex, newIndex]);
                    },
                  )
                : SizedBox();
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(flex: 4, child: SizedBox()),
              Hero(
                tag: "addButton",
                child: ButtonTheme(
                  height: 40,
                  minWidth: 60,
                  child: RaisedButton(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.add),
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddButtonDialog()),
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

class NoButtonsPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        alignment: Alignment.bottomCenter,
        height: 40,
        child: Text(
          'Add buttons here',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
