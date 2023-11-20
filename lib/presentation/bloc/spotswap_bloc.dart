import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotswap/domain/entities/token_entity.dart';
import 'package:spotswap/domain/usecases/authentication_usecase.dart';

part 'spotswap_event.dart';
part 'spotswap_state.dart';

class SpotSwapBloc extends Bloc<SpotSwapEvent, SpotSwapState> {
  SpotSwapBloc({
    required this.authenticationUseCase,
  }) : super(SpotSwapInitialState()) {
    on<SpotSwapEvent>((event, emit) async {
      if (event is AuthenticationEvent) {
        await _onAuthenticationEvent(event, emit);
      }
    });
  }
  final AuthenticationUseCase authenticationUseCase;
  FutureOr<void> _onAuthenticationEvent(
    AuthenticationEvent event,
    Emitter<SpotSwapState> emit,
  ) async {
    emit(SpotSwapLoadingState());
    final result =
        await authenticationUseCase(AuthenticationParams(code: event.code));
    emit(
      result.fold(
        (error) => SpotSwapErrorState(message: error.message),
        (token) => AuthenticationSuccessfulState(token: token),
      ),
    );
  }
}
