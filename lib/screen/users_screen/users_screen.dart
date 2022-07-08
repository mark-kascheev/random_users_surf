import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:random_users_surf/domain/model/random_user.dart';
import 'package:random_users_surf/screen/users_screen/users_screen_wm.dart';
import 'package:random_users_surf/screen/users_screen/widgets/users_app_bar.dart';
import 'package:shimmer/shimmer.dart';

class UsersScreen extends ElementaryWidget<UsersWidgetModel> {
  const UsersScreen({
    Key? key,
    WidgetModelFactory<UsersWidgetModel> wmFactory = createLoginWM,
  }) : super(key: key, wmFactory);

  @override
  Widget build(UsersWidgetModel wm) {
    return Scaffold(
      appBar: UsersAppBar(
        login: wm.userLogin,
        controller: wm.controller,
        onLogout: wm.logout,
        onSearchClean: wm.cleanSearchQuery,
      ),
      body: RefreshIndicator(
        onRefresh: wm.refreshList,
        child: EntityStateNotifierBuilder<List<RandomUser>?>(
          listenableEntityState: wm.users,
          loadingBuilder: (context, users) => ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) => _LoadingShimmerItem(),
          ),
          builder: (context, users) {
            if (users != null) {
              if (users.isNotEmpty) {
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return _UserListItem(
                      user: user,
                      onIconTap: wm.openUserDetails,
                    );
                  },
                );
              }
            }
            return const Center(child: Text('Empty list'));
          },
          errorBuilder: (context, error, users) =>
              const Center(child: Text('Error')),
        ),
      ),
    );
  }
}

class _LoadingShimmerItem extends StatelessWidget {
  final RandomUser mockUser = RandomUser(
    firstName: 'Random',
    lastName: 'Randomovich',
    age: 30,
    gender: 'unknown',
    phone: '0123124124124',
    email: 'random_user@example.com',
    imageUrl: '',
  );

  _LoadingShimmerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 16,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 16,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(flex: 2),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserListItem extends StatelessWidget {
  final RandomUser user;
  final Function(RandomUser) onIconTap;

  const _UserListItem({
    required this.user,
    required this.onIconTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => onIconTap(user),
            child: CircleAvatar(
              foregroundImage: NetworkImage(user.imageUrl),
              radius: 25,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${user.firstName} ${user.lastName}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  _randomizeCallIcon(user.phone),
                  const SizedBox(width: 4),
                  Text(
                    user.phone,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Выбираю иконку по первому символу телефона (особого рандома нет)
  Widget _randomizeCallIcon(String phone) {
    var icon = Icons.phone_callback;
    Color color = Colors.green;
    final firstPhoneDigit = phone.split('')[0];
    if (firstPhoneDigit == '0') {
      icon = Icons.phone_missed;
      color = Colors.red;
    }
    return Icon(icon, color: color, size: 20);
  }
}
