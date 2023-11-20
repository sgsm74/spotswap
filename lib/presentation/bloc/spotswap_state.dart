part of 'spotswap_bloc.dart';

sealed class SpotSwapState extends Equatable {
  const SpotSwapState();

  @override
  List<Object> get props => [];
}

final class SpotSwapInitialState extends SpotSwapState {}

final class SpotSwapLoadingState extends SpotSwapState {}

final class SpotSwapErrorState extends SpotSwapState {
  const SpotSwapErrorState({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

final class AuthenticationSuccessfulState extends SpotSwapState {
  const AuthenticationSuccessfulState({required this.token});
  final Token token;

  @override
  List<Object> get props => [token];
}
