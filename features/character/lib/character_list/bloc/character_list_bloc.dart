import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'character_list_state.dart';
part 'character_list_event.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  CharacterListBloc({
    required OfflineModeService offlineModeService,
    required CharacterRepository repository,
  }) : super(CharacterListState()) {
    _offlineModeService = offlineModeService;
    _repository = repository;

    on<CharacterListEvent>(
      (event, emit) => switch (event) {
        final _CharacterListFetched e => _fetch(e, emit),
        final _CharacterListFiltered e => _filter(e, emit),
        final _CharacterListOfflineModeToggled e => _toggleOfflineMode(e, emit),
      },
    );

    _offlineModeService.stream.listen(
      (bool modeActive) {
        add(_CharacterListOfflineModeToggled(activated: modeActive));
      },
    );
  }

  late final CharacterRepository _repository;
  late final OfflineModeService _offlineModeService;

  Future<void> _fetch(
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
      final data = await _repository.getList(
        query,
        returnCachedIfError: _offlineModeService.offlineModeActive,
      );

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
      final query = CharactersQuery(
        species: event.species,
        status: event.status,
        page: 1,
      );
      emit(
        state.copyWith(
          status: BlocStatusRecord.loading(),
          initial: true,
          query: query,
        ),
      );

      final data = await _repository.getList(
        query,
        returnCachedIfError: _offlineModeService.offlineModeActive,
      );

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

  Future<void> _toggleOfflineMode(
    _CharacterListOfflineModeToggled event,
    Emitter<CharacterListState> emit,
  ) async {
    // refresh list on any change
    add(CharacterListEvent.filter());
  }
}
