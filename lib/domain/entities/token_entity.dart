import 'package:equatable/equatable.dart';

class Token extends Equatable {
  const Token({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
  });

  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;

  @override
  List<Object> get props => [accessToken];
}
