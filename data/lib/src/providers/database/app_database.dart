import 'package:sqflite/sqflite.dart';

import 'tables/character_table.dart';

class AppDatabase {
  AppDatabase() {
    open();
  }

  Future<void> open() async {
    await openDatabase(
      'app_database.db',
      version: 1,
      onCreate: (db, _) => _initTables(db),
      onOpen: (db) => _db = db,
    );
  }

  late final Database _db;

  Future _initTables(Database db) async {
    await db.execute('''
      create table $tableCharacter (
        $characterColumnId integer not null,
        $characterColumnName text not null,
        $characterColumnStatus text not null,
        $characterColumnSpecies text not null,
        $characterColumnLocationName text not null,
        $characterColumnLocationUrl text not null,
        $characterColumnOriginName text not null,
        $characterColumnOriginUrl text not null,
        $characterColumnImage text not null
      )
    ''');
  }

  Future<List<Map<String, Object?>>> query(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    return _db.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  Future<int> insert(
    String table,
    Map<String, Object?> values, {
    String? nullColumnHack,
    ConflictAlgorithm? conflictAlgorithm,
  }) async {
    return _db.insert(
      table,
      values,
      nullColumnHack: nullColumnHack,
      conflictAlgorithm: conflictAlgorithm,
    );
  }
}
