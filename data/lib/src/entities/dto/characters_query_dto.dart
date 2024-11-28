import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../data.dart';

part 'characters_query_dto.g.dart';

@JsonSerializable()
class CharactersQueryDto extends PaginationDto {
  const CharactersQueryDto({this.species, this.status, super.page});

  @JsonKey(includeIfNull: false)
  final CharacterSpecies? species;
  @JsonKey(includeIfNull: false)
  final CharacterStatus? status;

  factory CharactersQueryDto.fromJson(Map<String, dynamic> json) =>
      _$CharactersQueryDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CharactersQueryDtoToJson(this);
}
