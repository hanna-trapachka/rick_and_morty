enum CharacterStatus {
  alive,
  dead,
  unknown;

  static CharacterStatus? fromString(String str) {
    switch (str) {
      case 'Alive':
        return CharacterStatus.alive;
      case 'Dead':
        return CharacterStatus.dead;
      case 'Unknown':
        return CharacterStatus.unknown;
      default:
        return null;
    }
  }
}
