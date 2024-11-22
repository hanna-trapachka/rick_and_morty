import 'package:domain/domain.dart';

import '../../entities/entities.dart';

abstract class CharacterListPaginationMapper {
  static CharacterListPagination fromEntity(
    CharacterListPaginationEntity entity,
  ) =>
      CharacterListPagination(
        count: entity.count,
        pages: entity.count,
        next: entity.next,
        prev: entity.prev,
      );
}
