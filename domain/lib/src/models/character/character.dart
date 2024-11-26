import '../../../domain.dart';

class Character {
  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.location,
    required this.origin,
    required this.image,
  });

  final int id;
  final String name;
  final CharacterStatus status;
  final CharacterSpecies species;
  final Location location;
  final Location origin;
  final String image;
}
