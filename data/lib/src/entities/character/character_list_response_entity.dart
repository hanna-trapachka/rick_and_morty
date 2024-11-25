import 'package:json_annotation/json_annotation.dart';

import '../entities.dart';

part 'character_list_response_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class CharacterListResponseEntity {
  const CharacterListResponseEntity({
    required this.info,
    required this.results,
  });

  final CharacterListPaginationEntity info;
  final List<CharacterEntity> results;

  factory CharacterListResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CharacterListResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterListResponseEntityToJson(this);
}
