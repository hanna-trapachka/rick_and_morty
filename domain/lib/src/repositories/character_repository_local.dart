import '../models/models.dart';

abstract class CharacterRepositoryLocal {
  Future<CharacterListResponse> getCharacters(CharactersQuery query);
}
