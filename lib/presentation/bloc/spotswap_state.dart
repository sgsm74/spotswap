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

final class GetProfileSuccessfulState extends SpotSwapState {
  const GetProfileSuccessfulState({required this.profile});
  final Profile profile;

  @override
  List<Object> get props => [profile];
}

class GetUserPlayListsSuccessfulState extends SpotSwapState {
  const GetUserPlayListsSuccessfulState({required this.playLists});
  final List<PlayList> playLists;

  @override
  List<Object> get props => [playLists];
}

class GetMyTracksSuccessfulState extends SpotSwapState {
  const GetMyTracksSuccessfulState({required this.tracks});
  final List<Track> tracks;

  @override
  List<Object> get props => [tracks];
}
