import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:random_users_surf/app_model.dart';
import 'package:random_users_surf/data/service/auth_service.dart';
import 'package:random_users_surf/screen/login_screen/login_screen.dart';
import 'package:random_users_surf/screen/login_screen/login_screen_model.dart';
import 'package:random_users_surf/screen/users_screen/users_screen.dart';
import 'package:get_it/get_it.dart';

class LoginWidgetModel extends WidgetModel<LoginScreen, LoginScreenModel> {
  final AppModel _appModel;
  final TextEditingController loginFieldController = TextEditingController();
  final ValueNotifier<bool> buttonEnabled = ValueNotifier<bool>(false);

  LoginWidgetModel(super.model, {required AppModel appModel})
      : _appModel = appModel;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _appModel.addListener(onAuthUser);
    loginFieldController.addListener(onTextChanged);
  }

  void onTextChanged() {
    if (_isInputLoginValid()) {
      buttonEnabled.value = true;
    } else {
      buttonEnabled.value = false;
    }
  }

  void onLoginPressed() {
    if (_isInputLoginValid()) {
      buttonEnabled.value = true;
      model.loginUser(loginFieldController.text);
    }
  }

  void onAuthUser() {
    buttonEnabled.value = false;
    if (_appModel.user != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const UsersScreen()));
    }
  }

  bool _isInputLoginValid() {
    final inputLogin = loginFieldController.text.trim();
    if (inputLogin.isEmpty) {
      return false;
    }
    return true;
  }
}

LoginWidgetModel createLoginWM(BuildContext _) {
  final getIt = GetIt.instance;
  final appModel = getIt<AppModel>();
  return LoginWidgetModel(
      appModel: appModel,
      LoginScreenModel(appModel: appModel, authService: getIt<AuthService>()));
}
