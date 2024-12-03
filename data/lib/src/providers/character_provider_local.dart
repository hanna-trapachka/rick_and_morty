import 'package:core/core.dart';

import '../../data.dart';

import 'database/app_database.dart';
import 'database/tables/character_table.dart';

class CharacterProviderLocal {
  final AppDatabase db;

  const CharacterProviderLocal(this.db);

  Future<int> insert(CharacterRecord character) async {
    return db.insert(tableCharacter, character.toMap());
  }

  Future<List<CharacterRecord>> getCharacters(CharactersQueryDto query) async {
    final speciesQuery = query.species != null
        ? "$characterColumnSpecies = '${query.species!.name.capitalize()}'"
        : '';
    final statusQuery = query.status != null
        ? "$characterColumnStatus = '${query.status!.name.capitalize()}'"
        : '';
    final queryStr = [speciesQuery, statusQuery]
        .where((str) => str.isNotEmpty)
        .join(' and ');

    final List<Map<String, dynamic>> maps = await db.query(
      tableCharacter,
      where: queryStr.isNotEmpty ? queryStr : null,
    );

    return maps.map(CharacterRecord.fromMap).toList();
  }
}
