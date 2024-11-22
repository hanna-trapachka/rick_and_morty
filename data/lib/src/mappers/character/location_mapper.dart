import 'package:domain/domain.dart';

import '../../entities/entities.dart';

abstract class LocationMapper {
  static Location fromEntity(LocationEntity entity) =>
      Location(name: entity.name, url: entity.url);
}
