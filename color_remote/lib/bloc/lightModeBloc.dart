import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:ip_remote/models/light_mode.dart';
import 'package:ip_remote/services/database.dart';

class LightModeBloc {
  LightModeBloc() {
    _addLightModeStream.listen(_addLightMode);
    _deleteLightModeStream.listen(_removeLightMode);

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

  void _addLightMode(LightMode lightMode) {
    _inLightModeListSink.add((lightModeList != null ? (lightModeList..add(lightMode)) : [lightMode]).toList());
    databaseAddLightMode(lightMode);
  }

  void _removeLightMode(LightMode lightMode) {
    _inLightModeListSink.add(lightModeList.where((_lightMode) => _lightMode != lightMode).toList());
    databaseRemoveLightMode(lightMode);
  }

  void _loadData() async {
    _lightModeListController.add(await databaseLightModeList);
  }

  void close() {
    _lightModeListController.close();
    _addLightModeController.close();
    _deleteLightModeController.close();
  }
}
