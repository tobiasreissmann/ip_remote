import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> get ipAddressListDatabase async {
  String path = join(await getDatabasesPath(), 'ipAddresses.db');
  return await openDatabase(path);
}

Future<Database> get activeIpAddressDatabase async {
  String path = join(await getDatabasesPath(), 'activeIpAddress.db');
  return await openDatabase(path);
}

Future<List<String>> get databaseIpAddressList async {
  String path = join(await getDatabasesPath(), 'ipAddresses.db');
  Database database = await openDatabase(path,
      version: 1,
      onCreate: (Database db, int version) async =>
          await db.execute('CREATE TABLE IpAddresses (number TEXT PRIMARY KEY)'));
  List<Map> _list = await database.rawQuery('SELECT * FROM IpAddresses');
  List<String> _ipAddressList = [];
  _list.forEach((entry) => _ipAddressList.add(entry['number']));
  return _ipAddressList;
}

Future<String> get databaseActiveIpAddress async {
  String path = join(await getDatabasesPath(), 'activeIpAddress.db');
  Database database = await openDatabase(path,
      version: 1,
      onCreate: (Database db, int version) async =>
          await db.execute('CREATE TABLE ActiveIpAddress (number TEXT PRIMARY KEY)'));
  List<Map> _list = await database.rawQuery('SELECT * FROM ActiveIpAddress');
  List<String> _activeIpAddressList = [];
  _list.forEach((entry) => _activeIpAddressList.add(entry['number']));
  final _activeIpAddress = _activeIpAddressList.isEmpty ? '' : _activeIpAddressList[0];
  return _activeIpAddress;
}

void databaseAddIpAddress(String ipAddress) async {
  Database _database = await ipAddressListDatabase;
  await _database
      .transaction((txn) async => await txn.rawInsert('INSERT INTO IpAddresses(number) VALUES("$ipAddress")'));
}

void databaseRemoveIpAddress(String ipAddress) async {
  Database _database = await ipAddressListDatabase;
  await _database.rawDelete('DELETE FROM IpAddresses WHERE number = "$ipAddress"');
}

void databaseChangeActiveIpAddress(String ipAddress) async {
  Database _database = await activeIpAddressDatabase;
  await _database.rawDelete('DELETE FROM ActiveIpAddress');
  await _database
      .transaction((txn) async => await txn.rawInsert('INSERT INTO ActiveIpAddress(number) VALUES("$ipAddress")'));
}
