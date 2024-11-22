import 'package:domain/domain.dart';

import '../../entities/entities.dart';
import 'character_list_pagination_mapper.dart';
import 'character_mapper.dart';

abstract class CharacterListResponseMapper {
  static CharacterListResponse fromEntity(CharacterListResponseEntity entity) =>
      CharacterListResponse(
        info: CharacterListPaginationMapper.fromEntity(entity.info),
        results: entity.results.map(CharacterMapper.fromEntity).toList(),
      );
}
