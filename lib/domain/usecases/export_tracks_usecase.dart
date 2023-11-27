import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:spotswap/core/errors/errors.dart';
import 'package:spotswap/core/utils/usecase.dart';
import 'package:spotswap/domain/entities/track_entity.dart';
import 'package:spotswap/domain/repository/repository.dart';

class ExportTracksUseCase extends UseCase<void, ExportTracksParams> {
  ExportTracksUseCase({required this.repository});

  final Repository repository;
  @override
  Future<Either<Failure, void>> call(ExportTracksParams params) =>
      repository.exportMyTracks(params.tracks, params.account);
}

class ExportTracksParams extends Equatable {
  const ExportTracksParams({
    required this.tracks,
    required this.account,
  });

  final List<Track> tracks;
  final String account;

  @override
  List<Object> get props => [account];
}
