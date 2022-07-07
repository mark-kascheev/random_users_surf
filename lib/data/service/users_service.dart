import 'package:random_users_surf/domain/model/random_user.dart';

// Определение интерфейса для сервиса по получению случайных пользователей
abstract class UsersService {
  Future<List<RandomUser>> getUsers();
}