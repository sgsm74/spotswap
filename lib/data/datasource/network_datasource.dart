import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:spotswap/core/consts/config.dart';
import 'package:spotswap/core/consts/consts.dart';
import 'package:spotswap/core/errors/exceptions.dart';
import 'package:spotswap/core/services/http_service.dart';
import 'package:spotswap/data/models/token_model.dart';

abstract class NetworkDatasource {
  Future<TokenModel> authentication();
}

class NetworkDatasourceImpl implements NetworkDatasource {
  const NetworkDatasourceImpl({required this.http});

  final HTTPService http;
  @override
  Future<TokenModel> authentication() async {
    try {
      final bytes = utf8.encode('${ApiKeys.clientId}:+${ApiKeys.clientSecret}');
      final base64Str = base64.encode(bytes);
      final result = await http.postData(
        ServerPaths.authentication,
        data: {
          'grant_type': 'authorization_code',
          'code': 'code', //TODO
          'redirect_uri': ApiKeys.redirectUrl,
        },
        header: {
          'Authorization': 'Basic $base64Str',
          Headers.contentTypeHeader: 'application/x-www-form-urlencoded',
        },
      );
      return TokenModel.fromJson(result.data);
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? '');
    }
  }
}
