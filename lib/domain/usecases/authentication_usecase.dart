import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:spotswap/core/errors/errors.dart';
import 'package:spotswap/core/utils/usecase.dart';
import 'package:spotswap/domain/entities/token_entity.dart';
import 'package:spotswap/domain/repository/repository.dart';

class AuthenticationUseCase extends UseCase<Token, AuthenticationParams> {
  AuthenticationUseCase({required this.repository});

  final Repository repository;
  @override
  Future<Either<Failure, Token>> call(params) =>
      repository.authentication(params.code);
}

class AuthenticationParams extends Equatable {
  const AuthenticationParams({required this.code});

  final String code;

  @override
  List<Object> get props => [code];
}
