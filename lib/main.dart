import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:random_users_surf/app_model.dart';
import 'package:random_users_surf/data/service/auth_service.dart';
import 'package:random_users_surf/data/service/auth_service_impl.dart';
import 'package:random_users_surf/data/service/users_service.dart';
import 'package:random_users_surf/data/service/users_service_impl.dart';
import 'package:random_users_surf/screen/login_screen/login_screen.dart';

void main() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<AppModel>(AppModel());
  getIt.registerSingleton<AuthService>(AuthServiceImpl());
  getIt.registerSingleton<UsersService>(UsersServiceImpl(
      Dio(BaseOptions(baseUrl: 'https://randomuser.me/api/'))));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginScreen());
  }
}
