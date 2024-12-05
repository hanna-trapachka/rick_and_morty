part of 'character_list_bloc.dart';

sealed class CharacterListEvent extends Equatable {
  const CharacterListEvent();

  factory CharacterListEvent.fetch() => const _CharacterListFetched();
  factory CharacterListEvent.filter({
    CharacterSpecies? species,
    CharacterStatus? status,
  }) =>
      _CharacterListFiltered(species: species, status: status);

  @override
  List<Object?> get props => [];
}

final class _CharacterListFetched extends CharacterListEvent {
  const _CharacterListFetched();
}

final class _CharacterListFiltered extends CharacterListEvent {
  const _CharacterListFiltered({this.species, this.status});

  final CharacterSpecies? species;
  final CharacterStatus? status;

  @override
  List<Object?> get props => [species, status];
}

final class _CharacterListOfflineModeToggled extends CharacterListEvent {
  const _CharacterListOfflineModeToggled({required this.activated});

  final bool activated;

  @override
  List<Object?> get props => [activated];
}
