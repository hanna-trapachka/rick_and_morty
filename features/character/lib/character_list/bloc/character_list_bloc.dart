import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'character_list_state.dart';
part 'character_list_event.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  CharacterListBloc(this.getListUseCase)
      : super(const CharacterListFreshLoading()) {
    on<CharacterListEvent>(
      (event, emit) => switch (event) {
        final _CharacterListFetched e => _fetch(e, emit),
      },
    );
  }

  late final GetCharacterListUseCase getListUseCase;

  Future<void> _fetch(
    _CharacterListFetched event,
    Emitter<CharacterListState> emit,
  ) async {
    if (event.refresh) {
      return _refresh(event, emit);
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

  Future<void> _refresh(
    _CharacterListFetched event,
    Emitter<CharacterListState> emit,
  ) async {
    final query = CharactersQuery(species: event.species, status: event.status);

    try {
      emit(CharacterListFreshLoading(query: query));

      final data = await getListUseCase.execute(query);

      emit(
        CharacterListIdle(
          data: data.results,
          query: query,
          hasReachedMax: data.info.next == null,
        ),
      );
    } catch (e) {
      emit(CharacterListError(e.toString(), query: query));
    }
  }
}
