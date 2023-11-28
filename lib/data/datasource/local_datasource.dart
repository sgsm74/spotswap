import 'package:hive/hive.dart';
import 'package:spotswap/domain/entities/token_entity.dart';
import 'package:spotswap/domain/entities/track_entity.dart';

abstract class LocalDatasource {
  Future<void> saveToken(Token token);
  Future<Token> getToken();
  Future<void> saveMyTracks(List<Track> tracks, String account);
  Future<List<Track>> loadMyTracks(String account);
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
    await Hive.deleteBoxFromDisk('myTracks');
    final box = await Hive.openBox('myTracks');
    for (final track in tracks) {
      await box.add(track);
    }
    await box.close();
  }

  @override
  Future<List<Track>> loadMyTracks(String account) async {
    final box = await Hive.openBox<Track>('myTracks');
    final list = box.values.toList();
    await box.close();
    return list;
  }
}
