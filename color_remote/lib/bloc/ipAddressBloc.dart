import 'dart:async';
import 'package:rxdart/rxdart.dart';

class IpAddressBloc {
  IpAddressBloc() {
    _addIpAddressStream.listen(_addIpAddress);
    _deleteIpAddressStream.listen(_removeIpAddress);
    _changeActiveIpAdressStream.listen(_changeActiveIpAddress);
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
  }

  void _removeIpAddress(String ipAddress) {
    _inIpAddressListSink.add(ipAddressList.where((_ipAddress) => _ipAddress != ipAddress).toList());
  }

  void _changeActiveIpAddress(String ipAddress) {
    _inActiveIpAddressSink.add(ipAddress);
  }

  void close() {
    _ipAddressListController.close();
    _addIpAddressController.close();
    _deleteIpAddressController.close();
    _activeIpAddressController.close();
    _changeActiveIpAdress.close();
  }
}
