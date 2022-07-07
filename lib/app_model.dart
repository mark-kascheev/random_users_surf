import 'package:flutter/foundation.dart';
import 'package:random_users_surf/domain/model/auth_user.dart';

// Хранит состояние залогиненного пользователя
class AppModel extends ChangeNotifier {
  AuthUser? user;

  void onChange(AuthUser? newUser) {
    user = newUser;
    notifyListeners();
  }
}