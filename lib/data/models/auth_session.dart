class AuthSession {
  final String token;

  AuthSession({required this.token});

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    return AuthSession(token: json['token']);
  }
}
