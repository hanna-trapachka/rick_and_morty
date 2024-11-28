import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  CharacterListBloc(this._getListUseCase) : super(CharacterListState()) {
    on<CharacterListEvent>(
      (event, emit) => switch (event) {
        final _CharacterListFetched e => _query(e, emit),
        final _CharacterListFiltered e => _filter(e, emit),
      },
    );
  }

  final GetCharacterListUseCase _getListUseCase;

  Future<void> _query(
    _CharacterListFetched event,
    Emitter<CharacterListState> emit,
  ) async {
    try {
      emit(state.copyWith(status: BlocStatusRecord.loading()));

      // for testing purposes
      await Future.delayed(const Duration(seconds: 2), () => null);

      final nextPage = state.query.page + 1;
      final query = CharactersQuery(
        page: nextPage,
        status: state.query.status,
        species: state.query.species,
      );
      final data = await _getListUseCase.execute(query);

      emit(
        state.copyWith(
          status: BlocStatusRecord.idle(),
          data: [...state.data, ...data.results],
          query: query,
          hasReachedMax: data.info.next == null,
          initial: false,
        ),
      );
    } on RestClientException catch (e) {
      emit(
        state.copyWith(
          status: BlocStatusRecord.error(e.message),
          initial: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BlocStatusRecord.error(e.toString()),
          initial: false,
        ),
      );
    }
  }

  Future<void> _filter(
    _CharacterListFiltered event,
    Emitter<CharacterListState> emit,
  ) async {
    try {
      final query =
          CharactersQuery(species: event.species, status: event.status);
      emit(
        state.copyWith(
          status: BlocStatusRecord.loading(),
          initial: true,
          query: query,
        ),
      );

      // for testing purposes
      await Future.delayed(const Duration(seconds: 2), () => null);

      final data = await _getListUseCase.execute(query);

      emit(
        state.copyWith(
          status: BlocStatusRecord.idle(),
          data: data.results,
          query: query,
          hasReachedMax: data.info.next == null,
          initial: false,
        ),
      );
    } on RestClientException catch (e) {
      emit(
        state.copyWith(
          status: BlocStatusRecord.error(e.message),
          initial: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BlocStatusRecord.error(e.toString()),
          initial: false,
        ),
      );
    }
  }
}

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
