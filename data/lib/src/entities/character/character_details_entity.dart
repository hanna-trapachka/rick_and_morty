import 'package:json_annotation/json_annotation.dart';

import '../entities.dart';

part 'character_details_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class CharacterDetailsEntity {
  const CharacterDetailsEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.location,
    required this.origin,
    required this.image,
    required this.episode,
  });

  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final LocationEntity location;
  final LocationEntity origin;
  final String image;
  final List<String> episode;

  factory CharacterDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$CharacterDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterDetailsEntityToJson(this);
}
