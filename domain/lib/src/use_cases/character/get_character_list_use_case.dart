import '../../../domain.dart';

class GetCharacterListUseCase
    extends FutureUseCase<CharactersQuery, CharacterListResponse> {
  GetCharacterListUseCase({
    required this.characterRepository,
    required this.characterRepositoryLocal,
    required this.connectivityService,
  });

  final CharacterRepository characterRepository;
  final CharacterRepositoryLocal characterRepositoryLocal;
  final ConnectivityService connectivityService;

  @override
  Future<CharacterListResponse> execute(CharactersQuery input) async {
    if (connectivityService.connected) {
      return characterRepository.getList(input);
    } else {
      return characterRepositoryLocal.getCharacters(input);
    }
  }
}
