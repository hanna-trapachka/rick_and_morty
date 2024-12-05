part of 'character_list_bloc.dart';

sealed class CharacterListEvent extends Equatable {
  const CharacterListEvent();

  factory CharacterListEvent.fetch({
    CharacterSpecies? species,
    CharacterStatus? status,
    bool refresh = false,
  }) =>
      _CharacterListFetched(
        species: species,
        status: status,
        refresh: refresh,
      );

  @override
  List<Object?> get props => [];
}

final class _CharacterListFetched extends CharacterListEvent {
  const _CharacterListFetched({
    this.species,
    this.status,
    required this.refresh,
  });

  final CharacterSpecies? species;
  final CharacterStatus? status;
  final bool refresh;

  @override
  List<Object?> get props => [species, status, refresh];
}
