import 'package:json_annotation/json_annotation.dart';

part 'pagination_dto.g.dart';

@JsonSerializable()
class PaginationDto {
  const PaginationDto({this.page = 0});

  final int page;

  factory PaginationDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationDtoToJson(this);
}
