import '../../models/models.dart';
import '../../repositories/repositories.dart';
import '../use_case.dart';

class GetCharacterListUseCase
    extends FutureUseCase<Pagination, CharacterListResponse> {
  GetCharacterListUseCase(this._characterRepository);

  final CharacterRepository _characterRepository;

  @override
  Future<CharacterListResponse> execute(Pagination input) async {
    return _characterRepository.getList(input);
  }
}
