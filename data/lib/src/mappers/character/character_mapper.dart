import 'package:domain/domain.dart';

import '../../entities/entities.dart';
import '../mappers.dart';

abstract class CharacterMapper {
  static Character fromEntity(CharacterEntity entity) => Character(
        id: entity.id,
        name: entity.name,
        status: entity.status,
        species: entity.species,
        location: LocationMapper.fromEntity(entity.location),
        origin: LocationMapper.fromEntity(entity.origin),
        image: entity.image,
      );
}
