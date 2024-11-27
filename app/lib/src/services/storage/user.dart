
import 'package:leafy_demo/src/services/storage/generics.dart';

class UserStorage {
  final StringStorage _accessToken = StringStorage(key: 'user_access_token');
  final StringStorage _refreshToken = StringStorage(key: 'user_refresh_token');

  StringStorage get accessToken => _accessToken;
  StringStorage get refreshToken => _refreshToken;

  Future<void> purge() async {
    await _accessToken.purge();
    await _refreshToken.purge();
  }
}