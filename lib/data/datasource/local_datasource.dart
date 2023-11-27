import 'package:hive/hive.dart';
import 'package:spotswap/domain/entities/token_entity.dart';
import 'package:spotswap/domain/entities/track_entity.dart';

abstract class LocalDatasource {
  Future<void> saveToken(Token token);
  Future<Token> getToken();
  Future<void> saveMyTracks(List<Track> tracks, String account);
}

class LocalDatasourceImpl implements LocalDatasource {
  @override
  Future<Token> getToken() async {
    final box = await Hive.openBox<Token>('token');
    final token = box.get(0)!;
    return token;
  }

  @override
  Future<void> saveToken(Token token) async {
    final box = await Hive.openBox<Token>('token');
    await box.add(token);
    await box.close();
  }

  @override
  Future<void> saveMyTracks(List<Track> tracks, String account) async {
    final box = await Hive.openBox<List<Track>>('myTracks');
    await box.put(account, tracks);
    await box.close();
  }
}
