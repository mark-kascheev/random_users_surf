import 'package:elementary/elementary.dart';
import 'package:random_users_surf/app_model.dart';
import 'package:random_users_surf/data/service/users_service.dart';
import 'package:random_users_surf/domain/model/random_user.dart';

// Модель для взаимодействия с сетевым слоем и состоянием логина
class UsersScreenModel extends ElementaryModel {
  final UsersService _service;
  final AppModel _appModel;
  String? get userLogin => _appModel.user?.login; // Позволяет получить логин уже залогиненного пользователя

  UsersScreenModel({required UsersService service, required AppModel appModel}) : _service = service, _appModel = appModel;

  // Получение пользователей из сети
  Future<List<RandomUser>> getUsers() async {
    return _service.getUsers();
  }

  // Разлогин пользователя
  void logout() {
    _appModel.onChange(null);
  }
}