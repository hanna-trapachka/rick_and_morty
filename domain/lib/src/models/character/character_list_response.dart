import 'character.dart';
import 'character_list_pagination.dart';

class CharacterListResponse {
  const CharacterListResponse({required this.info, required this.results});

  final CharacterListPagination info;
  final List<Character> results;
}
