import 'package:spotswap/core/consts/config.dart';

class ServerPaths {
  ServerPaths._();
  final String authorizationBaseUrl = 'https://accounts.spotify.com';
  static String baseUrl = 'https://api.spotify.com/v1';
  static String authorize = 'https://accounts.spotify.com/authorize';
  static String authentication = 'https://accounts.spotify.com/api/token/';
}

class ImageAssets {
  ImageAssets._();
  static String spotify = 'assets/images/spotify.png';
}

class AuthorizeParameters {
  AuthorizeParameters._();
  static String responseType = 'code';
  static String clientId = ApiKeys.clientId;
  static String clientSecret = ApiKeys.clientSecret;
  static String scope =
      'user-read-private user-read-email playlist-read playlist-read-private playlist-modify-public playlist-modify-private user-library-read';
  static String redirecUrl = ApiKeys.redirectUrl;
  static String state = 'spotify_auth_state';
  static String url =
      '${ServerPaths.authorize}?response_type=$responseType&client_id=$clientId&redirect_uri=$redirecUrl&state=$state';
}
