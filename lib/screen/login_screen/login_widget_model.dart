import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:random_users_surf/app_model.dart';
import 'package:random_users_surf/screen/login_screen/login_screen.dart';
import 'package:random_users_surf/screen/login_screen/login_screen_model.dart';
import 'package:random_users_surf/screen/users_screen/users_screen.dart';

class LoginWidgetModel extends WidgetModel<LoginScreen, LoginScreenModel> {
  TextEditingController loginFieldController = TextEditingController();
  final AppModel _appModel;
  LoginWidgetModel(super.model, {required AppModel appModel}) : _appModel = appModel;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _appModel.addListener(onAuthUser);
  }

  void onLoginPressed() {
    model.loginUser(loginFieldController.text);
  }

  void onAuthUser() {
    if(_appModel.user != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const UsersScreen()));
    }
  }
 }