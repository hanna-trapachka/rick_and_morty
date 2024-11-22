import 'package:domain/domain.dart';

import '../entities/entities.dart';

abstract class PaginationMapper {
  static PaginationDto toDto(Pagination pagination) =>
      PaginationDto(page: pagination.page);
}
