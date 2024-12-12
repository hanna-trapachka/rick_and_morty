part of 'character_list_bloc.dart';

sealed class CharacterListEvent extends Equatable {
  const CharacterListEvent();

  factory CharacterListEvent.fetch({bool refresh = false}) =>
      _CharacterListFetched(refresh: refresh);

  factory CharacterListEvent.filterBySpecies(String? species) =>
      _CharacterBySpeciesFiltered(species);

  factory CharacterListEvent.filterByStatus(String? status) =>
      _CharacterByStatusFiltered(status);

  @override
  List<Object?> get props => [];
}

final class _CharacterListFetched extends CharacterListEvent {
  const _CharacterListFetched({
    required this.refresh,
  });

  final bool refresh;

  @override
  List<Object?> get props => [refresh];
}

final class _CharacterByStatusFiltered extends CharacterListEvent {
  const _CharacterByStatusFiltered(this.status);

  final String? status;

  @override
  List<Object?> get props => [status];
}

final class _CharacterBySpeciesFiltered extends CharacterListEvent {
  const _CharacterBySpeciesFiltered(this.species);

  final String? species;

  @override
  List<Object?> get props => [species];
}
