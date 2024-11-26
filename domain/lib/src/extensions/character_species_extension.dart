import 'package:core/core.dart';

import '../../domain.dart';

extension CharacterSpeciesX on CharacterSpecies {
  String localize() {
    switch (this) {
      case CharacterSpecies.alien:
        return LocaleKeys.character_species_alien.tr();
      case CharacterSpecies.human:
        return LocaleKeys.character_species_human.tr();
    }
  }
}
