import '../../../domain.dart';

class CharactersQuery {
  const CharactersQuery({this.species, this.status, this.page = 1});

  final CharacterSpecies? species;
  final CharacterStatus? status;
  final int page;
}
