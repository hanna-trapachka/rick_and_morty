import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc() : super(ConnectivityInitial()) {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      final isConnected = !result.contains(ConnectivityResult.none);
      print("connectivity status - ${result}");
      add(_ConnectivityChanged(isConnected: isConnected));
    });

    on<ConnectivityEvent>(
      (event, emit) => switch (event) {
        final _ConnectivityChanged e => _connectivityChanged(e, emit),
      },
    );
  }

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  void _connectivityChanged(
    _ConnectivityChanged event,
    Emitter<ConnectivityState> emit,
  ) {
    if (event.isConnected) {
      emit(ConnectivitySuccess());
    } else {
      emit(ConnectivityFailure());
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivitySuccess extends ConnectivityState {}

class ConnectivityFailure extends ConnectivityState {
  @override
  List<Object> get props => [];
}

sealed class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  factory ConnectivityEvent.change({required bool isConnected}) =>
      _ConnectivityChanged(isConnected: isConnected);

  @override
  List<Object> get props => [];
}

class _ConnectivityChanged extends ConnectivityEvent {
  final bool isConnected;

  const _ConnectivityChanged({required this.isConnected});

  @override
  List<Object> get props => [isConnected];
}
