import '../../../../data.dart';

const tableCharacter = 'character';
const characterColumnId = 'id';
const characterColumnName = 'name';
const characterColumnStatus = 'status';
const characterColumnSpecies = 'species';
const characterColumnLocationName = 'locationName';
const characterColumnLocationUrl = 'locationUrl';
const characterColumnOriginName = 'originName';
const characterColumnOriginUrl = 'originUrl';
const characterColumnImage = 'image';

class CharacterRecord extends CharacterEntity {
  CharacterRecord({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.location,
    required super.origin,
    required super.image,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        characterColumnId: super.id,
        characterColumnName: super.name,
        characterColumnStatus: super.status,
        characterColumnSpecies: super.species,
        characterColumnLocationName: super.location.name,
        characterColumnLocationUrl: super.location.url,
        characterColumnOriginName: super.origin.name,
        characterColumnOriginUrl: super.origin.url,
        characterColumnImage: super.image,
      };

  factory CharacterRecord.fromMap(Map<String, dynamic> map) => CharacterRecord(
        id: (map[characterColumnId] as num).toInt(),
        name: map[characterColumnName] as String,
        status: map[characterColumnStatus] as String,
        species: map[characterColumnSpecies] as String,
        location: LocationEntity.fromJson(
          {
            'name': map[characterColumnLocationName],
            'url': map[characterColumnLocationUrl],
          },
        ),
        origin: LocationEntity.fromJson(
          {
            'name': map[characterColumnOriginName],
            'url': map[characterColumnOriginUrl],
          },
        ),
        image: map[characterColumnImage] as String,
      );
}
