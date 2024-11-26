import 'package:domain/domain.dart';

import '../../entities/entities.dart';
import '../mappers.dart';

abstract class CharacterMapper {
  static Character fromEntity(CharacterEntity entity) => Character(
        id: entity.id,
        name: entity.name,
        status: CharacterStatus.fromString(entity.status) ??
            CharacterStatus.unknown,
        species: CharacterSpecies.fromString(entity.species) ??
            CharacterSpecies.human,
        location: LocationMapper.fromEntity(entity.location),
        origin: LocationMapper.fromEntity(entity.origin),
        image: entity.image,
      );
}
