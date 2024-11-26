enum CharacterSpecies {
  alien,
  human;

  static CharacterSpecies? fromString(String str) {
    switch (str) {
      case 'Alien':
        return CharacterSpecies.alien;
      case 'Human':
        return CharacterSpecies.human;
      default:
        return null;
    }
  }
}
