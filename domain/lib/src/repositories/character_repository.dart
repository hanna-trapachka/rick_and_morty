import '../models/models.dart';

abstract class CharacterRepository {
  Future<CharacterListResponse> getList(CharactersQuery query);
  Future<CharacterDetails> getById(int id);
}
