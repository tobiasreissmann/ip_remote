import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> get database async {
  String path = join(await getDatabasesPath(), 'ipRemote.db');
  return await openDatabase(path);
}

Future<List<String>> get databaseIpAddressList async {
  String path = join(await getDatabasesPath(), 'ipRemote.db');
  Database database = await openDatabase(path,
      version: 1,
      onCreate: (Database db, int version) async =>
          await db.execute('CREATE TABLE IpAddresses (address TEXT PRIMARY KEY, active BIT)'));
  List<Map> _list = await database.rawQuery('SELECT * FROM IpAddresses');
  List<String> _ipAddressList = [];
  _list.forEach((entry) => _ipAddressList.add(entry['address']));
  return _ipAddressList;
}

Future<String> get databaseActiveIpAddress async {
  Database _database = await database;
  List<Map> _list = await _database.rawQuery('SELECT address FROM IpAddresses WHERE active = 1');
  if(_list.isNotEmpty) return _list[0]['address'];
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
