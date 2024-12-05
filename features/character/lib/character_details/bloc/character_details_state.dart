part of 'character_details_bloc.dart';

sealed class CharacterDetailsState extends Equatable {
  const CharacterDetailsState();

  @override
  List<Object?> get props => [];
}

final class CharacterDetailsLoading extends CharacterDetailsState {
  const CharacterDetailsLoading();
}

final class CharacterDetailsIdle extends CharacterDetailsState {
  const CharacterDetailsIdle(this.character);

  final CharacterDetails character;

  @override
  List<Object?> get props => [character];
}

final class CharacterDetailsError extends CharacterDetailsState {
  const CharacterDetailsError(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
