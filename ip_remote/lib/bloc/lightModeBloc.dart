import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:ip_remote/models/light_mode.dart';
import 'package:ip_remote/services/database.dart';

class LightModeBloc {
  LightModeBloc() {
    _addLightModeStream.listen(_addLightMode);
    _deleteLightModeStream.listen(_removeLightMode);
    _reorderLightModesStream.listen(_reorderLightModes);

    _loadData();
  }

  final _lightModeListController = BehaviorSubject<List<LightMode>>();
  StreamSink<List<LightMode>> get _inLightModeListSink => _lightModeListController.sink;
  Stream<List<LightMode>> get lightModeListStream => _lightModeListController.stream;
  List<LightMode> get lightModeList => _lightModeListController.value;

  final _addLightModeController = StreamController<LightMode>();
  StreamSink<LightMode> get addLightMode => _addLightModeController.sink;
  Stream<LightMode> get _addLightModeStream => _addLightModeController.stream;

  final _deleteLightModeController = StreamController<LightMode>();
  StreamSink<LightMode> get deleteLightMode => _deleteLightModeController.sink;
  Stream<LightMode> get _deleteLightModeStream => _deleteLightModeController.stream;

  final _reorderLightModesController = StreamController<List<int>>();
  StreamSink<List<int>> get reorderLightModes => _reorderLightModesController.sink;
  Stream<List<int>> get _reorderLightModesStream => _reorderLightModesController.stream;

  void _addLightMode(LightMode lightMode) {
    _inLightModeListSink.add((lightModeList != null ? (lightModeList..add(lightMode)) : [lightMode]).toList());
    databaseAddLightMode(lightMode);
  }

  void _removeLightMode(LightMode lightMode) {
    _inLightModeListSink.add(lightModeList.where((_lightMode) => _lightMode != lightMode).toList());
    databaseRemoveLightMode(lightMode);
  }

  void _reorderLightModes(List<int> indizes) {
    if (indizes[0] == indizes[1]) return;
    List<LightMode> _list = lightModeList.toList();
    LightMode _lightMode = _list[indizes[0]];
    _list.removeAt(indizes[0]);
    _list.insert(indizes[1], _lightMode);
    _inLightModeListSink.add(_list.toList());
    databaseSaveLightModes(_list);
  }

  void _loadData() async {
    _lightModeListController.add(await databaseLightModeList);
  }

  void close() {
    _lightModeListController.close();
    _addLightModeController.close();
    _deleteLightModeController.close();
    _reorderLightModesController.close();
  }
}
