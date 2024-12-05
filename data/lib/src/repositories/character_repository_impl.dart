import 'package:core/core.dart';
import 'package:domain/domain.dart';

import '../../data.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  CharacterRepositoryImpl({
    required CharacterProvider characterProvider,
    required CharacterProviderLocal localProvider,
  }) {
    _characterProvider = characterProvider;
    _localProvider = localProvider;
  }

  late final CharacterProvider _characterProvider;
  late final CharacterProviderLocal _localProvider;

  @override
  Future<CharacterDetails> getById(int id) async {
    final response = await _characterProvider.getById(id);
    return CharacterDetailsMapper.fromEntity(response);
  }

  @override
  Future<CharacterListResponse> getList(
    CharactersQuery query, {
    bool returnCachedIfError = false,
  }) async {
    final queryDto = CharactersQueryMapper.toDto(query);

    late final CharacterListResponseEntity response;

    try {
      response = await _characterProvider.getList(queryDto);
    } catch (e) {
      AppLogger().error(e.toString());
      throw ClientException(message: e.toString());
    }

    try {
      await Future.wait(
        response.results.map(
          (character) =>
              _localProvider.insert(CharacterMapper.toTableRecord(character)),
        ),
      );
    } catch (e) {
      AppLogger().error(e.toString());
    }

    return CharacterListResponseMapper.fromEntity(response);
  }
}
