import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:random_users_surf/app_model.dart';
import 'package:random_users_surf/data/service/auth_service.dart';
import 'package:random_users_surf/screen/login_screen/login_screen.dart';
import 'package:random_users_surf/screen/login_screen/login_screen_model.dart';
import 'package:random_users_surf/screen/users_screen/users_screen.dart';

class LoginWidgetModel extends WidgetModel<LoginScreen, LoginScreenModel> {
  final TextEditingController loginFieldController = TextEditingController();
  final ValueNotifier<bool> buttonEnabled = ValueNotifier<bool>(false);
  final AppModel _appModel;

  LoginWidgetModel(super.model, {required AppModel appModel})
      : _appModel = appModel;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _appModel.addListener(onAuthUser);
    loginFieldController.addListener(onTextChanged);
  }

  @override
  void dispose() {
    loginFieldController
      ..removeListener(onTextChanged)
      ..dispose();
    buttonEnabled.dispose();
    _appModel.removeListener(onAuthUser);

    super.dispose();
  }

  void onTextChanged() {
    buttonEnabled.value = _isInputLoginValid();
  }

  void onLoginPressed() {
    if (_isInputLoginValid()) {
      buttonEnabled.value = true;
      model.loginUser(loginFieldController.text.trim());
    }
  }

  void onAuthUser() {
    buttonEnabled.value = false;
    if (_appModel.user != null) {
      Navigator.of(context).push(
        MaterialPageRoute<UsersScreen>(builder: (_) => const UsersScreen()),
      );
    }
  }

  bool _isInputLoginValid() {
    return loginFieldController.text.trim().isNotEmpty;
  }
}

LoginWidgetModel createLoginWM(BuildContext _) {
  final getIt = GetIt.instance;
  final appModel = getIt<AppModel>();
  return LoginWidgetModel(
    appModel: appModel,
    LoginScreenModel(appModel: appModel, authService: getIt<AuthService>()),
  );
}
