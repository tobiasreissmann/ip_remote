import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:ip_remote/models/light_mode.dart';

Future<Database> get database async {
  String path = join(await getDatabasesPath(), 'ipRemote.db');
  return await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE IpAddresses (address TEXT PRIMARY KEY, active BIT)');
      await db.execute(
          'CREATE TABLE LightModes (button TEXT, feedback TEXT, path TEXT, PRIMARY KEY (button, feedback, path))');
    },
  );
}

Future<List<String>> get databaseIpAddressList async {
  Database _database = await database;
  List<Map> _list = await _database.rawQuery('SELECT * FROM IpAddresses');
  List<String> _ipAddressList = [];
  _list.forEach((entry) => _ipAddressList.add(entry['address']));
  return _ipAddressList;
}

Future<List<LightMode>> get databaseLightModeList async {
  Database _database = await database;
  List<Map> _list = await _database.rawQuery('SELECT * FROM LightModes');
  List<LightMode> _lightModesList = [];
  _list.forEach((entry) => _lightModesList.add(LightMode(entry['button'], entry['feedback'], entry['string'])));
  return _lightModesList;
}

Future<String> get databaseActiveIpAddress async {
  Database _database = await database;
  List<Map> _list = await _database.rawQuery('SELECT address FROM IpAddresses WHERE active = 1');
  if (_list.isNotEmpty) return _list[0]['address'];
  return null;
}

void databaseAddIpAddress(String ipAddress) async {
  Database _database = await database;
  await _database
      .transaction((txn) async => await txn.rawInsert('INSERT INTO IpAddresses(address) VALUES("$ipAddress")'));
}

void databaseRemoveIpAddress(String ipAddress) async {
  Database _database = await database;
  await _database.rawDelete('DELETE FROM IpAddresses WHERE address = "$ipAddress"');
}

void databaseChangeActiveIpAddress(String ipAddress) async {
  Database _database = await database;
  await _database.rawUpdate('UPDATE IpAddresses SET active = 0');
  await _database.rawUpdate('UPDATE IpAddresses SET active = 1 WHERE address = "$ipAddress"');
}

void databaseAddLightMode(LightMode lightMode) async {
  Database _database = await database;
  await _database.transaction((txn) async => await txn.rawInsert(
      'INSERT INTO LightModes(button, feedback, path) VALUES("${lightMode.button}", "${lightMode.feedback}", "${lightMode.path}")'));
}

void databaseRemoveLightMode(LightMode lightMode) async {
  Database _database = await database;
  await _database.rawDelete(
      'DELETE FROM LightModes WHERE button = "${lightMode.button}" AND feedback = "${lightMode.feedback}" AND path = "${lightMode.path}"');
}
