import 'package:hive/hive.dart';
import 'package:spotswap/domain/entities/token_entity.dart';

abstract class LocalDatasource {
  Future<void> saveToken(Token token);
  Future<Token> getToken();
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
}
