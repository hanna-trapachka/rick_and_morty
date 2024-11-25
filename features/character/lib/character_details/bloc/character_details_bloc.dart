import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
