import 'package:domain/domain.dart';

import '../../../data.dart';

abstract class CharactersQueryMapper {
  static CharactersQueryDto toDto(CharactersQuery query) => CharactersQueryDto(
        page: query.page,
        species: query.species,
        status: query.status,
      );
}
