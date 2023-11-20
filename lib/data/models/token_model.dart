import 'package:spotswap/domain/entities/token_entity.dart';

class TokenModel extends Token {
  const TokenModel({
    required super.accessToken,
    required super.refreshToken,
    required super.tokenType,
    required super.expiresIn,
  });
  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        accessToken: json['access_token'],
        refreshToken: json['refresh_token'],
        tokenType: json['token_type'],
        expiresIn: json['expires_in'],
      );
}
