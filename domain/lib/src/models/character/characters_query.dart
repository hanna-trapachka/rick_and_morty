import '../../../domain.dart';

class CharactersQuery {
  const CharactersQuery({this.species, this.status, this.page = 0});

  final CharacterSpecies? species;
  final CharacterStatus? status;
  final int page;
}
