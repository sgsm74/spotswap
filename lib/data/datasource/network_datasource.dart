import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:spotswap/core/consts/consts.dart';
import 'package:spotswap/core/errors/exceptions.dart';
import 'package:spotswap/core/services/http_service.dart';
import 'package:spotswap/data/models/profile_model.dart';
import 'package:spotswap/data/models/token_model.dart';
import 'package:spotswap/domain/entities/profile_entity.dart';
import 'package:spotswap/domain/entities/token_entity.dart';

abstract class NetworkDatasource {
  Future<void> setToken(Token token);
  Future<TokenModel> authentication(String code);
  Future<Profile> getProfile();
}

class NetworkDatasourceImpl implements NetworkDatasource {
  const NetworkDatasourceImpl({required this.http});

  final HTTPService http;
  @override
  Future<TokenModel> authentication(String code) async {
    try {
      final bytes = utf8.encode(
        '${AuthorizeParameters.clientId}:${AuthorizeParameters.clientSecret}',
      );
      final base64Str = base64.encode(bytes);
      final result = await http.postData(
        ServerPaths.authentication,
        data: {
          'grant_type': 'authorization_code',
          'code': code,
          'redirect_uri': AuthorizeParameters.redirecUrl,
        },
        header: {
          'Authorization': 'Basic $base64Str',
          Headers.contentTypeHeader: 'application/x-www-form-urlencoded',
        },
      );
      print(result.data['access_token']);
      return TokenModel.fromJson(result.data);
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? '');
    }
  }

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final result = await http.getData(
        ServerPaths.profile,
        header: {
          'Authorization': http.getToken(),
        },
      );
      return ProfileModel.fromJson(result.data);
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? '');
    }
  }

  @override
  Future<void> setToken(Token token) async => http.setToken(token.accessToken);
}
