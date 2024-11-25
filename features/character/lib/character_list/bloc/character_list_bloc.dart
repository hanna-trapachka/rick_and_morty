import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  CharacterListBloc(this._getListUseCase) : super(CharacterListState()) {
    on<CharacterListEvent>(
      (event, emit) => switch (event) {
        final _CharacterListListFetched e => _query(e, emit),
      },
    );
  }

  final GetCharacterListUseCase _getListUseCase;

  Future<void> _query(
    _CharacterListListFetched event,
    Emitter<CharacterListState> emit,
  ) async {
    try {
      emit(state.copyWith(status: BlocStatusRecord.loading()));

      final nextPage = state.page + 1;
      final data = await _getListUseCase.execute(Pagination(page: nextPage));

      emit(
        state.copyWith(
          status: BlocStatusRecord.idle(),
          data: [...state.data, ...data.results],
          page: nextPage,
          hasReachedMax: data.info.next == null,
          initial: false,
        ),
      );
    } on RestClientException catch (e) {
      emit(state.copyWith(status: BlocStatusRecord.error(e.message)));
    } catch (e) {
      emit(state.copyWith(status: BlocStatusRecord.error(e.toString())));
    }
  }
}

final class CharacterListState extends Equatable {
  CharacterListState({
    BlocStatusRecord? status,
    this.data = const [],
    this.page = 0,
    this.hasReachedMax = false,
    this.initial = true,
  }) : status = status ?? BlocStatusRecord.loading();

  final BlocStatusRecord status;
  final List<Character> data;
  final int page;
  final bool hasReachedMax;
  final bool initial;

  CharacterListState copyWith({
    BlocStatusRecord? status,
    List<Character>? data,
    int? page,
    bool? hasReachedMax,
    bool? initial,
  }) =>
      CharacterListState(
        status: status ?? this.status,
        data: data ?? this.data,
        page: page ?? this.page,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        initial: initial ?? this.initial,
      );

  @override
  List<Object?> get props => [status, data, page, hasReachedMax];
}

sealed class CharacterListEvent extends Equatable {
  const CharacterListEvent();

  factory CharacterListEvent.fetch() => const _CharacterListListFetched();

  @override
  List<Object?> get props => [];
}

final class _CharacterListListFetched extends CharacterListEvent {
  const _CharacterListListFetched();
}
