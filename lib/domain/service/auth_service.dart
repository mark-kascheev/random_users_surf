import 'package:random_users_surf/domain/model/auth_user.dart';

abstract class AuthService {
  Future<AuthUser> login(String login);

  Future<void> logout();
}