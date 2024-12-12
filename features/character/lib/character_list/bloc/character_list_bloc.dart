import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'character_list_state.dart';
part 'character_list_event.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  CharacterListBloc(this.getListUseCase) : super(const CharacterListLoading()) {
    on<CharacterListEvent>(
      (event, emit) => switch (event) {
        final _CharacterListFetched e => _fetch(e, emit),
        final _CharacterByStatusFiltered e => _filterByStatus(e, emit),
        final _CharacterBySpeciesFiltered e => _filterBySpecies(e, emit),
      },
    );
  }

  late final GetCharacterListUseCase getListUseCase;

  final statusFilterValues =
      CharacterStatus.values.map((e) => e.name.capitalize()).toList();
  final speciesFilterValues =
      CharacterSpecies.values.map((e) => e.name.capitalize()).toList();

  Future<void> _fetch(
    _CharacterListFetched event,
    Emitter<CharacterListState> emit,
  ) async {
    if (event.refresh) {
      return _refresh(emit);
    }
    if (state is! CharacterListIdle) return;

    final idleState = state as CharacterListIdle;
    final query = CharactersQuery(
      page: idleState.query.page + 1,
      status: idleState.query.status,
      species: idleState.query.species,
    );

    try {
      final data = await getListUseCase.execute(query);

      emit(
        idleState.copyWith(
          data: [...idleState.data, ...data.results],
          query: query,
          hasReachedMax: data.info.next == null,
        ),
      );
    } catch (e) {
      emit(CharacterListError(e.toString(), query: query));
    }
  }

  Future<void> _filterByStatus(
    _CharacterByStatusFiltered event,
    Emitter<CharacterListState> emit,
  ) async {
    if (state is! CharacterListIdle) return;

    final status =
        event.status == null ? null : CharacterStatus.fromString(event.status!);

    emit(
      (state as CharacterListIdle).copyWith(
        query: CharactersQuery(
          species: state.query.species,
          status: status,
        ),
      ),
    );

    await _refresh(emit);
  }

  Future<void> _filterBySpecies(
    _CharacterBySpeciesFiltered event,
    Emitter<CharacterListState> emit,
  ) async {
    if (state is! CharacterListIdle) return;

    final species = event.species == null
        ? null
        : CharacterSpecies.fromString(event.species!);

    emit(
      (state as CharacterListIdle).copyWith(
        query: CharactersQuery(
          species: species,
          status: state.query.status,
        ),
      ),
    );

    await _refresh(emit);
  }

  Future<void> _refresh(Emitter<CharacterListState> emit) async {
    try {
      emit(CharacterListLoading(query: state.query));

      final data = await getListUseCase.execute(state.query);

      emit(
        CharacterListIdle(
          data: data.results,
          query: state.query,
          hasReachedMax: data.info.next == null,
        ),
      );
    } catch (e) {
      emit(CharacterListError(e.toString(), query: state.query));
    }
  }
}
