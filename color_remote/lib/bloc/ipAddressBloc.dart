import 'dart:async';
import 'package:color_remote/services/database.dart';
import 'package:rxdart/rxdart.dart';

class IpAddressBloc {
  IpAddressBloc() {
    _addIpAddressStream.listen(_addIpAddress);
    _deleteIpAddressStream.listen(_removeIpAddress);
    _changeActiveIpAdressStream.listen(_changeActiveIpAddress);

    _loadData();
  }

  final _ipAddressListController = BehaviorSubject<List<String>>();
  StreamSink<List<String>> get _inIpAddressListSink => _ipAddressListController.sink;
  Stream<List<String>> get ipAddressListStream => _ipAddressListController.stream;
  List<String> get ipAddressList => _ipAddressListController.value;

  final _activeIpAddressController = BehaviorSubject<String>();
  StreamSink<String> get _inActiveIpAddressSink => _activeIpAddressController.sink;
  Stream<String> get activeIpAddressStream => _activeIpAddressController.stream;
  String get activeIpAddress => _activeIpAddressController.value;

  final _changeActiveIpAdress = StreamController<String>();
  StreamSink<String> get changeActiveIpAddress => _changeActiveIpAdress.sink;
  Stream<String> get _changeActiveIpAdressStream => _changeActiveIpAdress.stream;

  final _addIpAddressController = StreamController<String>();
  StreamSink<String> get addIpAddress => _addIpAddressController.sink;
  Stream<String> get _addIpAddressStream => _addIpAddressController.stream;

  final _deleteIpAddressController = StreamController<String>();
  StreamSink<String> get deleteIpAddress => _deleteIpAddressController.sink;
  Stream<String> get _deleteIpAddressStream => _deleteIpAddressController.stream;

  void _addIpAddress(String ipAddress) {
    _inIpAddressListSink.add((ipAddressList != null ? (ipAddressList..add(ipAddress)) : [ipAddress]).toList());
    databaseAddIpAddress(ipAddress);
  }

  void _removeIpAddress(String ipAddress) {
    _inIpAddressListSink.add(ipAddressList.where((_ipAddress) => _ipAddress != ipAddress).toList());
    databaseRemoveIpAddress(ipAddress);
  }

  void _changeActiveIpAddress(String ipAddress) {
    _inActiveIpAddressSink.add(ipAddress);
    databaseChangeActiveIpAddress(ipAddress);
  }

  void _loadData() async {
    _inIpAddressListSink.add(await databaseIpAddressList);
    _inActiveIpAddressSink.add(await databaseActiveIpAddress);
  }

  void close() {
    _ipAddressListController.close();
    _addIpAddressController.close();
    _deleteIpAddressController.close();
    _activeIpAddressController.close();
    _changeActiveIpAdress.close();
  }
}
