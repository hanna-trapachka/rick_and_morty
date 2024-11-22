import '../../models/models.dart';
import '../../repositories/repositories.dart';
import '../use_case.dart';

class GetCharacterDetailsUseCase extends FutureUseCase<int, CharacterDetails> {
  GetCharacterDetailsUseCase(this._characterRepository);

  final CharacterRepository _characterRepository;

  @override
  Future<CharacterDetails> execute(int input) async {
    return _characterRepository.getById(input);
  }
}
