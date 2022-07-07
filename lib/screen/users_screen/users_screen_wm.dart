import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:random_users_surf/app_model.dart';
import 'package:random_users_surf/data/service/users_service.dart';
import 'package:random_users_surf/domain/model/random_user.dart';
import 'package:random_users_surf/screen/login_screen/login_screen.dart';
import 'package:random_users_surf/screen/users_screen/users_screen_model.dart';
import 'package:random_users_surf/screen/users_screen/users_screen.dart';

class UsersWidgetModel extends WidgetModel<UsersScreen, UsersScreenModel> {
  final TextEditingController controller = TextEditingController();
  final EntityStateNotifier<List<RandomUser>?> _listUsers =
      EntityStateNotifier(null);

  ListenableState<EntityState<List<RandomUser>?>> get users => _listUsers;
  List<RandomUser> _allUsers = [];
  final String userLogin;

  UsersWidgetModel(super.model) : userLogin = model.userLogin;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _loadUsers();
    controller.addListener(_onUserSearch);
  }

  Future<void> _loadUsers() async {
    _listUsers.loading();
    try {
      final users = await model.getUsers();
      _allUsers = users;
      _listUsers.content(users);
    } on Exception catch (err) {
      _listUsers.error(err, _allUsers);
    }
  }

  void _onUserSearch() {
    final users = _allUsers;
    if (users.isNotEmpty) {
      final text = controller.text.trim();
      if (text.isNotEmpty) {
        _listUsers.loading();

        final result = users
            .where((user) => (user.firstName.contains(text) ||
                user.lastName.contains(text) ||
                user.email.contains(text) ||
                user.phone.contains(text)))
            .toList();

        _listUsers.content(result);
      }
    }
  }

  Future<void> refreshList() async {
    _loadUsers();
  }

  void logout() {
    model.logout();
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  void openUserDetails(RandomUser user) {
    // TODO add a navigation to user details
  }
}

UsersWidgetModel createLoginWM(BuildContext _) {
  final getIt = GetIt.instance;
  return UsersWidgetModel(UsersScreenModel(
      service: getIt<UsersService>(), appModel: getIt<AppModel>()));
}