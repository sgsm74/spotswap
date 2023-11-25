part of 'spotswap_bloc.dart';

sealed class SpotSwapEvent extends Equatable {
  const SpotSwapEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationEvent extends SpotSwapEvent {
  const AuthenticationEvent({required this.code});
  final String code;

  @override
  List<Object> get props => [code];
}

class GetProfileEvent extends SpotSwapEvent {}

class GetUserPlayListsEvent extends SpotSwapEvent {
  const GetUserPlayListsEvent({required this.userId});
  final String userId;

  @override
  List<Object> get props => [userId];
}

class GetMyTracksEvent extends SpotSwapEvent {}
