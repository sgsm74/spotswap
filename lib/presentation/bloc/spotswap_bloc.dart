import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotswap/core/utils/usecase.dart';
import 'package:spotswap/domain/entities/playlist_entity.dart';
import 'package:spotswap/domain/entities/profile_entity.dart';
import 'package:spotswap/domain/entities/token_entity.dart';
import 'package:spotswap/domain/entities/track_entity.dart';
import 'package:spotswap/domain/usecases/authentication_usecase.dart';
import 'package:spotswap/domain/usecases/export_tracks_usecase.dart';
import 'package:spotswap/domain/usecases/get_my_tracks_usecase.dart';
import 'package:spotswap/domain/usecases/get_profile_usecase.dart';
import 'package:spotswap/domain/usecases/get_user_playlists_usecase.dart';
import 'package:spotswap/domain/usecases/load_my_tracks_usecase.dart';

part 'spotswap_event.dart';
part 'spotswap_state.dart';

class SpotSwapBloc extends Bloc<SpotSwapEvent, SpotSwapState> {
  SpotSwapBloc({
    required this.authenticationUseCase,
    required this.getProfileUseCase,
    required this.getUserPlayListsUseCase,
    required this.getMyTracksUseCase,
    required this.exportTracksUseCase,
    required this.loadMyTracksUseCase,
  }) : super(SpotSwapInitialState()) {
    on<SpotSwapEvent>((event, emit) async {
      if (event is AuthenticationEvent) {
        await _onAuthenticationEvent(event, emit);
      } else if (event is GetProfileEvent) {
        await _onGetProfileEvent(event, emit);
      } else if (event is GetUserPlayListsEvent) {
        await _onGetUserPlayListsEvent(event, emit);
      } else if (event is GetMyTracksEvent) {
        await _onGetMyTracksEvent(event, emit);
      } else if (event is ExportMyTracksEvent) {
        await _onExportMyTracksEvent(event, emit);
      } else if (event is LoadMyTracksEvent) {
        await _onLoadMyTracksEvent(event, emit);
      }
    });
  }
  final AuthenticationUseCase authenticationUseCase;
  final GetProfileUseCase getProfileUseCase;
  final GetUserPlayListsUseCase getUserPlayListsUseCase;
  final GetMyTracksUseCase getMyTracksUseCase;
  final ExportTracksUseCase exportTracksUseCase;
  final LoadMyTracksUseCase loadMyTracksUseCase;
  FutureOr<void> _onAuthenticationEvent(
    AuthenticationEvent event,
    Emitter<SpotSwapState> emit,
  ) async {
    emit(SpotSwapLoadingState(event: event));
    final result =
        await authenticationUseCase(AuthenticationParams(code: event.code));
    emit(
      result.fold(
        (error) => SpotSwapErrorState(message: error.message),
        (token) => AuthenticationSuccessfulState(token: token),
      ),
    );
  }

  FutureOr<void> _onGetProfileEvent(
    GetProfileEvent event,
    Emitter<SpotSwapState> emit,
  ) async {
    emit(SpotSwapLoadingState(event: event));
    final result = await getProfileUseCase(NoParams());
    emit(
      result.fold(
        (error) => SpotSwapErrorState(message: error.message),
        (profile) => GetProfileSuccessfulState(profile: profile),
      ),
    );
  }

  FutureOr<void> _onGetUserPlayListsEvent(
    GetUserPlayListsEvent event,
    Emitter<SpotSwapState> emit,
  ) async {
    emit(SpotSwapLoadingState(event: event));
    final result = await getUserPlayListsUseCase(event.userId);
    emit(
      result.fold(
        (error) => SpotSwapErrorState(message: error.message),
        (playLists) => GetUserPlayListsSuccessfulState(playLists: playLists),
      ),
    );
  }

  FutureOr<void> _onGetMyTracksEvent(
    GetMyTracksEvent event,
    Emitter<SpotSwapState> emit,
  ) async {
    emit(SpotSwapLoadingState(event: event));
    final result = await getMyTracksUseCase(NoParams());
    emit(
      result.fold(
        (error) => SpotSwapErrorState(message: error.message),
        (tracks) => GetMyTracksSuccessfulState(tracks: tracks),
      ),
    );
  }

  FutureOr<void> _onExportMyTracksEvent(
    ExportMyTracksEvent event,
    Emitter<SpotSwapState> emit,
  ) async {
    emit(SpotSwapLoadingState(event: event));
    final result = await exportTracksUseCase(
      ExportTracksParams(tracks: event.tracks, account: event.account),
    );
    emit(
      result.fold(
        (error) => SpotSwapErrorState(message: error.message),
        (ok) => ExportMyTracksSuccessfulState(),
      ),
    );
  }

  FutureOr<void> _onLoadMyTracksEvent(
    LoadMyTracksEvent event,
    Emitter<SpotSwapState> emit,
  ) async {
    emit(SpotSwapLoadingState(event: event));
    final result = await loadMyTracksUseCase(
      event.account,
    );
    emit(
      result.fold(
        (error) => SpotSwapErrorState(message: error.message),
        (tracks) => LoadMyTracksSuccessfulState(tracks: tracks),
      ),
    );
  }
}
