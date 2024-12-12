import 'package:domain/domain.dart';

import '../../entities/entities.dart';
import '../mappers.dart';

abstract class CharacterDetailsMapper {
  static CharacterDetails fromEntity(CharacterDetailsEntity entity) =>
      CharacterDetails(
        id: entity.id,
        name: entity.name,
        status: CharacterStatus.fromString(entity.status) ??
            CharacterStatus.unknown,
        species: CharacterSpecies.fromString(entity.species) ??
            CharacterSpecies.human,
        type: entity.type,
        gender: entity.gender,
        location: LocationMapper.fromEntity(entity.location),
        origin: LocationMapper.fromEntity(entity.origin),
        image: entity.image,
        episode: entity.episode,
      );
}
