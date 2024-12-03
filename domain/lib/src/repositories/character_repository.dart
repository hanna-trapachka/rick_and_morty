import '../models/models.dart';

abstract class CharacterRepository {
  Future<CharacterListResponse> getList(
    CharactersQuery query, {
    bool returnCachedIfError,
  });
  Future<CharacterDetails> getById(int id);
}
