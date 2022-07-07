import 'package:random_users_surf/domain/model/auth_user.dart';
import 'package:random_users_surf/data/service/auth_service.dart';

class AuthServiceImpl implements AuthService {

  @override
  Future<AuthUser> login(String login) {
    return Future.delayed(const Duration(seconds: 1), () => AuthUser(login: login));
  }

  @override
  Future<void> logout() {
    return Future.delayed(const Duration(milliseconds: 1));
  }
}