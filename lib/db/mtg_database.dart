import 'package:collectors_bank/models/mtg_set.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:collectors_bank/models/mtg_card.dart';
import 'package:collectors_bank/models/mtg_set.dart';

class MTGDatabase {
  static final MTGDatabase instance = MTGDatabase();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database =
        await _initDB('C:\\Users\\theen\\Desktop\\collectors_bank_mtg.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  Future<List<MTGSet>> selectAllSets() async {
    final db = await instance.database;

    final maps = await db.query(
      tableSets,
      orderBy: '${MTGSetFields.date} ASC',
    );

    if (maps.isNotEmpty) {
      return maps.map((json) => MTGSet.fromJson(json)).toList();
    } else {
      throw Exception('Error during the fetch of all MTG Sets.');
    }
  }

  Future<List<MTGCard>> selectAllCardsBySet(String setcode) async {
    final db = await instance.database;

    final maps = await db.query(
      tableCards,
      where: '${MTGCardFields.set} = ?',
      whereArgs: [setcode],
      orderBy: '${MTGCardFields.number} ASC',
    );

    if (maps.isNotEmpty) {
      return maps.map((json) => MTGCard.fromJson(json)).toList();
    } else {
      throw Exception('No cards associated with setCode: $setcode.');
    }
  }
}
