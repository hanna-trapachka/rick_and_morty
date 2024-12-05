import 'package:domain/domain.dart';

import '../entities/entities.dart';
import 'providers.dart';

class CharacterProvider {
  CharacterProvider(this._apiProvider);

  final ApiProvider _apiProvider;

  Future<CharacterListResponseEntity> getList(CharactersQueryDto query) async {
    final response =
        await _apiProvider.get('/character', queryParams: query.toJson());

    if (response == null) {
      throw const ClientException(message: 'Character list response is null');
    }

    return CharacterListResponseEntity.fromJson(response);
  }

  Future<CharacterDetailsEntity> getById(
    int id,
  ) async {
    final response = await _apiProvider.get('/character/$id');

    if (response == null) {
      throw const ClientException(
        message: 'Character details response is null',
      );
    }

    return CharacterDetailsEntity.fromJson(response);
  }
}
