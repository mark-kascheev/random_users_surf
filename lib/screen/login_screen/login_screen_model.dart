import 'package:elementary/elementary.dart';
import 'package:random_users_surf/app_model.dart';
import 'package:random_users_surf/domain/service/auth_service.dart';

class LoginScreenModel extends ElementaryModel {
  final AuthService _authService;
  final AppModel _appModel;

  LoginScreenModel(
      {required AuthService authService, required AppModel appModel})
      : _authService = authService,
        _appModel = appModel;

  void loginUser(String login) {
    _authService.login(login).then((authUser) {
      _appModel.onChange(authUser);
    });
  }
}
