part of 'character_list_bloc.dart';

sealed class CharacterListState extends Equatable {
  const CharacterListState({
    this.query = const CharactersQuery(),
  });

  final CharactersQuery query;

  @override
  List<Object?> get props => [query];
}

final class CharacterListLoading extends CharacterListState {
  const CharacterListLoading({super.query});

  @override
  List<Object?> get props => [query];
}

final class CharacterListError extends CharacterListState {
  const CharacterListError(this.error, {super.query});

  final String error;

  @override
  List<Object?> get props => [error, query];
}

final class CharacterListIdle extends CharacterListState {
  const CharacterListIdle({
    this.data = const [],
    this.hasReachedMax = false,
    super.query,
  });

  final List<Character> data;
  final bool hasReachedMax;

  CharacterListIdle copyWith({
    List<Character>? data,
    CharactersQuery? query,
    bool? hasReachedMax,
    bool? isLoading,
  }) =>
      CharacterListIdle(
        data: data ?? this.data,
        query: query ?? this.query,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      );

  @override
  List<Object?> get props => [data, query, hasReachedMax];
}
