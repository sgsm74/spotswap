import 'package:dartz/dartz.dart';
import 'package:spotswap/core/errors/errors.dart';
import 'package:spotswap/core/utils/usecase.dart';
import 'package:spotswap/domain/entities/track_entity.dart';
import 'package:spotswap/domain/repository/repository.dart';

class ImportTracksUseCase extends UseCase<void, List<Track>> {
  ImportTracksUseCase({required this.repository});

  final Repository repository;
  @override
  Future<Either<Failure, void>> call(List<Track> params) =>
      repository.importTracks(params);
}
