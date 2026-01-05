import '../../core/network/api_client.dart';
import '../models/auth_session.dart';

class AuthRepository {
  final ApiClient _api;

  AuthRepository(this._api);

  Future<AuthSession> login(String email, String password) async {
    final data = await _api.post('/login', {
      "email": email,
      "password": password,
    });
    return AuthSession.fromJson(data);
  }
}
