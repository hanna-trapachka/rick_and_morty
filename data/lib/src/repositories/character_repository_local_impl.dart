import 'package:domain/domain.dart';

import '../../data.dart';

class CharacterRepositoryLocalImpl implements CharacterRepositoryLocal {
  CharacterRepositoryLocalImpl({
    required CharacterProviderLocal localProvider,
  }) : _localProvider = localProvider;

  late final CharacterProviderLocal _localProvider;

  @override
  Future<CharacterListResponse> getCharacters(CharactersQuery query) async {
    final queryDto = CharactersQueryMapper.toDto(query);

    final records = await _localProvider.getCharacters(queryDto);

    return CharacterListResponseMapper.fromEntity(
      CharacterListResponseEntity(
        info: CharacterListPaginationEntity(count: records.length, pages: 1),
        results: records,
      ),
    );
  }
}
