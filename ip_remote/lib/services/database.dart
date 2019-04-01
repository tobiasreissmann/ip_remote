import 'package:ip_remote/models/ip_address.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:ip_remote/models/light_mode.dart';

Future<Database> get database async {
  String path = join(await getDatabasesPath(), 'ipRemote.db');
  return await openDatabase(
    path,
    version: 2,
    onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE IpAddresses (address TEXT, desc TEXT, active BIT, PRIMARY KEY (address, desc))');
      await db.execute(
          'CREATE TABLE LightModes (button TEXT, feedback TEXT, path TEXT, PRIMARY KEY (button, feedback, path))');
    },
    onUpgrade: (Database db, int oldVersion, int newVersion) async {
      List<Map> _list = await db.rawQuery('SELECT * FROM IpAddresses');
      await db.execute('DROP TABLE IpAddresses');
      await db.execute('CREATE TABLE IpAddresses (address TEXT, desc TEXT, active BIT, PRIMARY KEY (address, desc))');
      _list.forEach((entry) => db.rawInsert(
          'INSERT INTO IpAddresses (address, desc, active) VALUES ("${entry['address']}", "IP-Address", "${entry['active']}")'));
    },
  );
}

Future<List<IpAddress>> get databaseIpAddressList async {
  Database _database = await database;
  List<Map> _list = await _database.rawQuery('SELECT * FROM IpAddresses');
  List<IpAddress> _ipAddressList = [];
  _list.forEach((entry) => _ipAddressList.add(IpAddress(entry['address'], entry['desc'])));
  return _ipAddressList;
}

Future<List<LightMode>> get databaseLightModeList async {
  Database _database = await database;
  List<Map> _list = await _database.rawQuery('SELECT * FROM LightModes');
  List<LightMode> _lightModesList = [];
  _list.forEach((entry) => _lightModesList.add(LightMode(entry['button'], entry['feedback'], entry['path'])));
  return _lightModesList;
}

Future<IpAddress> get databaseActiveIpAddress async {
  Database _database = await database;
  List<Map> _list = await _database.rawQuery('SELECT * FROM IpAddresses WHERE active = 1');
  if (_list.isNotEmpty) return IpAddress(_list[0]['address'], _list[0]['desc']);
  return null;
}

void databaseAddIpAddress(IpAddress ipAddress) async {
  Database _database = await database;
  await _database.transaction((txn) async => await txn
      .rawInsert('INSERT INTO IpAddresses(address, desc) VALUES("${ipAddress.address}", "${ipAddress.description}")'));
}

void databaseRemoveIpAddress(IpAddress ipAddress) async {
  Database _database = await database;
  await _database.rawDelete('DELETE FROM IpAddresses WHERE address = "${ipAddress.address}"');
}

void databaseChangeActiveIpAddress(IpAddress ipAddress) async {
  Database _database = await database;
  await _database.rawUpdate('UPDATE IpAddresses SET active = 0');
  if (ipAddress != null)
    await _database.rawUpdate(
        'UPDATE IpAddresses SET active = 1 WHERE address = "${ipAddress.address}" AND desc = "${ipAddress.description}"');
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
