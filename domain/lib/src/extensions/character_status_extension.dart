import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain.dart';

extension CharacterStatusX on CharacterStatus {
  String localize() {
    switch (this) {
      case CharacterStatus.alive:
        return LocaleKeys.character_status_alive.tr();
      case CharacterStatus.dead:
        return LocaleKeys.character_status_dead.tr();
      case CharacterStatus.unknown:
        return LocaleKeys.character_status_unknown.tr();
    }
  }

  Color get color {
    switch (this) {
      case CharacterStatus.alive:
        return Colors.green.shade800;
      case CharacterStatus.dead:
        return Colors.red.shade900;
      case CharacterStatus.unknown:
        return Colors.grey.shade800;
    }
  }
}
