import 'package:json_annotation/json_annotation.dart';

import '../entities.dart';

part 'character_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class CharacterEntity {
  const CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.location,
    required this.origin,
    required this.image,
  });

  final int id;
  final String name;
  final String status;
  final String species;
  final LocationEntity location;
  final LocationEntity origin;
  final String image;

  factory CharacterEntity.fromJson(Map<String, dynamic> json) =>
      _$CharacterEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterEntityToJson(this);
}
