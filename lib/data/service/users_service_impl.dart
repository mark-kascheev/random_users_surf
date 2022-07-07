import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:random_users_surf/data/service/users_service.dart';
import 'package:random_users_surf/domain/model/random_user.dart';

// Реализация сервиса по получению случайных пользователей
class UsersServiceImpl implements UsersService {
  final Dio _dio;

  UsersServiceImpl(this._dio);

  // Получить список пользователей, возможна пагинация
  @override
  Future<List<RandomUser>> getUsers({int page = 1, int pageSize = 50}) async {
    final response = await _dio.get<String>('?page=$page&results=$pageSize&seed=abc');

    final bodyJson = jsonDecode(response.data ?? '') as Map<String, dynamic>;

    return [
      for (final user in bodyJson['results'])
        RandomUser.fromJson(user as Map<String, dynamic>)
    ];
  }
}