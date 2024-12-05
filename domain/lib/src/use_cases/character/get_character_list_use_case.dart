import '../../models/models.dart';
import '../../repositories/repositories.dart';
import '../use_case.dart';

class GetCharacterListUseCase
    extends FutureUseCase<CharactersQuery, CharacterListResponse> {
  GetCharacterListUseCase({
    required this.characterRepository,
    required this.characterRepositoryLocal,
  });

  final CharacterRepository characterRepository;
  final CharacterRepositoryLocal characterRepositoryLocal;

  @override
  Future<CharacterListResponse> execute(CharactersQuery input) async {
    // TODO(ann): if no connection return local data else return from server
    return characterRepository.getList(input);
  }
}
