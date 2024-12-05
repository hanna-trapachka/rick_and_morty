import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'character_details_state.dart';
part 'character_details_event.dart';

class CharacterDetailsBloc
    extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  CharacterDetailsBloc(this._getCharacterUseCase)
      : super(const CharacterDetailsLoading()) {
    on<CharacterDetailsEvent>(
      (event, emit) => switch (event) {
        final _CharacterDetailsFetched e => _fetch(e, emit),
      },
    );
  }

  final GetCharacterDetailsUseCase _getCharacterUseCase;

  Future<void> _fetch(
    _CharacterDetailsFetched event,
    Emitter<CharacterDetailsState> emit,
  ) async {
    try {
      emit(const CharacterDetailsLoading());

      final data = await _getCharacterUseCase.execute(event.id);

      emit(CharacterDetailsIdle(data));
    } on RestClientException catch (e) {
      emit(CharacterDetailsError(e.message));
    } catch (e) {
      emit(CharacterDetailsError(e.toString()));
    }
  }
}
