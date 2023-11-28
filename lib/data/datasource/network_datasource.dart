import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:spotswap/core/consts/consts.dart';
import 'package:spotswap/core/errors/exceptions.dart';
import 'package:spotswap/core/services/http_service.dart';
import 'package:spotswap/data/models/pagination_data.dart';
import 'package:spotswap/data/models/playlist_model.dart';
import 'package:spotswap/data/models/profile_model.dart';
import 'package:spotswap/data/models/token_model.dart';
import 'package:spotswap/data/models/track_model.dart';
import 'package:spotswap/domain/entities/playlist_entity.dart';
import 'package:spotswap/domain/entities/profile_entity.dart';
import 'package:spotswap/domain/entities/token_entity.dart';

abstract class NetworkDatasource {
  Future<void> setToken(Token token);
  Future<Token> authentication(String code);
  Future<Profile> getProfile();
  Future<List<PlayList>> getUserPlaylists(String userId);
  Future<PaginationDataModel> getMyTracks(int limit, int offset);
  Future<void> updateUserTracks(List<String> trackIds);
  Future<void> importTracks(List<String> trackIds);
}

class NetworkDatasourceImpl implements NetworkDatasource {
  const NetworkDatasourceImpl({required this.http});

  final HTTPService http;
  @override
  Future<Token> authentication(String code) async {
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
  Future<Profile> getProfile() async {
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

  @override
  Future<List<PlayList>> getUserPlaylists(String userId) async {
    List<PlayListModel> playLists = [];
    try {
      final result = await http.getData(
        ServerPaths.getUserPlaylists(userId),
        header: {
          'Authorization': http.getToken(),
        },
      );
      //TODO pagination
      for (final playList in result.data['items']) {
        playLists.add(PlayListModel.fromJson(playList));
      }
      return playLists;
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? '');
    }
  }

  @override
  Future<PaginationDataModel> getMyTracks(int limit, int offset) async {
    try {
      final result = await http.getData(
        ServerPaths.userTracks,
        queryParameters: {
          'offset': offset,
          'limit': limit,
          'locale': 'en-US,en;q=0.9',
        },
        header: {
          'Authorization': http.getToken(),
        },
      );
      return PaginationDataModel<TrackModel>.fromJson(result.data, (e) {
        return TrackModel.fromJson(e);
      });
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? '');
    }
  }

  @override
  Future<void> updateUserTracks(List<String> trackIds) async {
    try {
      await http.postData(
        ServerPaths.userTracks,
        data: {
          'ids': trackIds,
        },
        header: {
          'Authorization': http.getToken(),
        },
      );
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? '');
    }
  }

  @override
  Future<void> importTracks(List<String> trackIds) async {
    try {
      await http.postData(
        ServerPaths.userTracks,
        data: {
          'ids': trackIds,
        },
        header: {
          'Authorization': http.getToken(),
        },
      );
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? '');
    }
  }
}
