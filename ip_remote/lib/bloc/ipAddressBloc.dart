import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:ip_remote/services/database.dart';
import 'package:ip_remote/models/ip_address.dart';

class IpAddressBloc {
  IpAddressBloc() {
    _addIpAddressStream.listen(_addIpAddress);
    _deleteIpAddressStream.listen(_removeIpAddress);
    _changeActiveIpAdressStream.listen(_changeActiveIpAddress);

    _loadData();
  }

  final _ipAddressListController = BehaviorSubject<List<IpAddress>>();
  StreamSink<List<IpAddress>> get _inIpAddressListSink => _ipAddressListController.sink;
  Stream<List<IpAddress>> get ipAddressListStream => _ipAddressListController.stream;
  List<IpAddress> get ipAddressList => _ipAddressListController.value;

  final _activeIpAddressController = BehaviorSubject<IpAddress>();
  StreamSink<IpAddress> get _inActiveIpAddressSink => _activeIpAddressController.sink;
  Stream<IpAddress> get activeIpAddressStream => _activeIpAddressController.stream;
  IpAddress get activeIpAddress => _activeIpAddressController.value;

  final _changeActiveIpAdress = StreamController<IpAddress>();
  StreamSink<IpAddress> get changeActiveIpAddress => _changeActiveIpAdress.sink;
  Stream<IpAddress> get _changeActiveIpAdressStream => _changeActiveIpAdress.stream;

  final _addIpAddressController = StreamController<IpAddress>();
  StreamSink<IpAddress> get addIpAddress => _addIpAddressController.sink;
  Stream<IpAddress> get _addIpAddressStream => _addIpAddressController.stream;

  final _deleteIpAddressController = StreamController<IpAddress>();
  StreamSink<IpAddress> get deleteIpAddress => _deleteIpAddressController.sink;
  Stream<IpAddress> get _deleteIpAddressStream => _deleteIpAddressController.stream;

  void _addIpAddress(IpAddress ipAddress) {
    _inIpAddressListSink.add((ipAddressList != null ? (ipAddressList..add(ipAddress)) : [ipAddress]).toList());
    if (ipAddressList.isEmpty || activeIpAddress == null) changeActiveIpAddress.add(ipAddress);
    databaseAddIpAddress(ipAddress);
  }

  void _removeIpAddress(IpAddress ipAddress) {
    _inIpAddressListSink.add(ipAddressList.where((_ipAddress) => _ipAddress != ipAddress).toList());
    if (activeIpAddress.address == ipAddress.address && activeIpAddress.description == ipAddress.description) changeActiveIpAddress.add(null);
    databaseRemoveIpAddress(ipAddress);
  }

  void _changeActiveIpAddress(IpAddress ipAddress) {
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
