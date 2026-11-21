class AppUser {
  final String name;
  final String email;
  final String password;

  const AppUser({
    required this.name,
    required this.email,
    required this.password,
  });
}

class AuthService {
  static final Map<String, AppUser> _users = {};

  static String _key(String email) => email.trim().toLowerCase();

  static bool register(AppUser user) {
    final key = _key(user.email);
    if (_users.containsKey(key)) {
      return false;
    }
    _users[key] = user;
    return true;
  }

  static AppUser? login(String email, String password) {
    final user = _users[_key(email)];
    if (user == null || user.password != password) {
      return null;
    }
    return user;
  }

  static bool update(String oldEmail, AppUser user) {
    final oldKey = _key(oldEmail);
    final newKey = _key(user.email);
    if (newKey != oldKey && _users.containsKey(newKey)) {
      return false;
    }
    _users.remove(oldKey);
    _users[newKey] = user;
    return true;
  }
}