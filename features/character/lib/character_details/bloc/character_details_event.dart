part of 'character_details_bloc.dart';

sealed class CharacterDetailsEvent extends Equatable {
  const CharacterDetailsEvent();

  factory CharacterDetailsEvent.fetch(int id) => _CharacterDetailsFetched(id);

  @override
  List<Object?> get props => [];
}

final class _CharacterDetailsFetched extends CharacterDetailsEvent {
  const _CharacterDetailsFetched(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}
