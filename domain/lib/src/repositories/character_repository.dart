import '../models/models.dart';

abstract class CharacterRepository {
  Future<CharacterListResponse> getList(Pagination pagination);
  Future<CharacterDetails> getById(int id);
}
