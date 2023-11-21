import 'package:dartz/dartz.dart';
import 'package:spotswap/core/errors/errors.dart';
import 'package:spotswap/core/utils/usecase.dart';
import 'package:spotswap/domain/entities/profile_entity.dart';
import 'package:spotswap/domain/repository/repository.dart';

class GetProfileUseCase extends UseCase<Profile, NoParams> {
  GetProfileUseCase({required this.repository});

  final Repository repository;
  @override
  Future<Either<Failure, Profile>> call(params) => repository.getProfile();
}
