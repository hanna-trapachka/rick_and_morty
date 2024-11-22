import 'package:domain/domain.dart';

import '../mappers/mappers.dart';
import '../providers/providers.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  CharacterRepositoryImpl(this._characterProvider);

  final CharacterProvider _characterProvider;

  @override
  Future<CharacterDetails> getById(int id) async {
    final response = await _characterProvider.getById(id);
    return CharacterDetailsMapper.fromEntity(response);
  }

  @override
  Future<CharacterListResponse> getList(Pagination pagination) async {
    final response =
        await _characterProvider.getList(PaginationMapper.toDto(pagination));
    return CharacterListResponseMapper.fromEntity(response);
  }
}
