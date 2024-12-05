part of 'character_list_bloc.dart';

final class CharacterListState extends Equatable {
  CharacterListState({
    BlocStatusRecord? status,
    this.data = const [],
    this.query = const CharactersQuery(),
    this.hasReachedMax = false,
    this.initial = true,
  }) : status = status ?? BlocStatusRecord.loading();

  final BlocStatusRecord status;
  final List<Character> data;
  final CharactersQuery query;
  final bool hasReachedMax;
  final bool initial;

  CharacterListState copyWith({
    BlocStatusRecord? status,
    List<Character>? data,
    CharactersQuery? query,
    bool? hasReachedMax,
    bool? initial,
  }) =>
      CharacterListState(
        status: status ?? this.status,
        data: data ?? this.data,
        query: query ?? this.query,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        initial: initial ?? this.initial,
      );

  @override
  List<Object?> get props => [status, data, query, hasReachedMax];
}
