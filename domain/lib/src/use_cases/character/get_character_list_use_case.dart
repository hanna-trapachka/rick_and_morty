import '../../../domain.dart';

class GetCharacterListUseCase
    extends FutureUseCase<CharactersQuery, CharacterListResponse> {
  GetCharacterListUseCase({
    required this.characterRepository,
    required this.characterRepositoryLocal,
    required this.getConnectivityStatusUseCase,
  });

  final CharacterRepository characterRepository;
  final CharacterRepositoryLocal characterRepositoryLocal;
  final GetConnectionStatusUseCase getConnectivityStatusUseCase;

  @override
  Future<CharacterListResponse> execute(CharactersQuery input) async {
    if (getConnectivityStatusUseCase.execute()) {
      return characterRepository.getList(input);
    } else {
      return characterRepositoryLocal.getCharacters(input);
    }
  }
}
