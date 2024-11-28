import '../../../domain.dart';

class CharactersQuery extends Pagination {
  const CharactersQuery({this.species, this.status, super.page});

  final CharacterSpecies? species;
  final CharacterStatus? status;
}
