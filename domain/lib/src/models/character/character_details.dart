import '../../../domain.dart';

class CharacterDetails {
  const CharacterDetails({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.location,
    required this.origin,
    required this.image,
    required this.episode,
  });

  final int id;
  final String name;
  final CharacterStatus status;
  final CharacterSpecies species;
  final String type;
  final String gender;
  final Location location;
  final Location origin;
  final String image;
  final List<String> episode;
}
