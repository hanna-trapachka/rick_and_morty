import '../../models/models.dart';
import '../../repositories/repositories.dart';
import '../use_case.dart';

class GetCharacterListUseCase
    extends FutureUseCase<CharactersQuery, CharacterListResponse> {
  GetCharacterListUseCase(this._characterRepository);

  final CharacterRepository _characterRepository;

  @override
  Future<CharacterListResponse> execute(CharactersQuery input) async {
    return _characterRepository.getList(input);
  }
}
