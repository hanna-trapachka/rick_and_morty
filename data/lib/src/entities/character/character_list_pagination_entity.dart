import 'package:json_annotation/json_annotation.dart';

part 'character_list_pagination_entity.g.dart';

@JsonSerializable()
class CharacterListPaginationEntity {
  const CharacterListPaginationEntity({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  final int count;
  final int pages;
  final String? next;
  final String? prev;

  factory CharacterListPaginationEntity.fromJson(Map<String, dynamic> json) =>
      _$CharacterListPaginationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterListPaginationEntityToJson(this);
}
