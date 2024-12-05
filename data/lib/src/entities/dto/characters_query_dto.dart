import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'characters_query_dto.g.dart';

@JsonSerializable()
class CharactersQueryDto {
  const CharactersQueryDto({this.species, this.status, this.page = 0});

  @JsonKey(includeIfNull: false)
  final CharacterSpecies? species;
  @JsonKey(includeIfNull: false)
  final CharacterStatus? status;
  final int page;

  factory CharactersQueryDto.fromJson(Map<String, dynamic> json) =>
      _$CharactersQueryDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CharactersQueryDtoToJson(this);
}
