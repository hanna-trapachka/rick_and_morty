import 'package:json_annotation/json_annotation.dart';

part 'location_entity.g.dart';

@JsonSerializable()
class LocationEntity {
  const LocationEntity({required this.name, required this.url});

  final String name;
  final String url;

  factory LocationEntity.fromJson(Map<String, dynamic> json) =>
      _$LocationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LocationEntityToJson(this);
}
