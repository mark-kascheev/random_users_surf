import 'package:flutter/material.dart';

class UsersAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String login;
  final VoidCallback onLogout;
  final VoidCallback onSearchClean;
  final TextEditingController controller;

  const UsersAppBar({
    Key? key,
    required this.login,
    required this.onLogout,
    required this.controller,
    required this.onSearchClean,
  }) : super(key: key);

  @override
  State<UsersAppBar> createState() => _UsersAppBarState();

  @override
  Size get preferredSize => const Size(double.infinity, 64);
}

class _UsersAppBarState extends State<UsersAppBar> {
  bool _searchSelected = false;

  @override
  Widget build(BuildContext context) {
    return _searchSelected
        ? _SearchAppBar(
            controller: widget.controller,
            onPressed: () {
              _updateAppBar();
              widget.onSearchClean();
            },
          )
        : _LoginExitAppBar(
            login: widget.login,
            onPressed: _updateAppBar,
            onLogout: widget.onLogout,
          );
  }

  void _updateAppBar() {
    setState(() {
      _searchSelected = !_searchSelected;
    });
  }
}

class _LoginExitAppBar extends StatelessWidget {
  final String login;
  final VoidCallback onPressed;
  final VoidCallback onLogout;

  const _LoginExitAppBar({
    Key? key,
    required this.onPressed,
    required this.login,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text(login),
      actions: [
        IconButton(icon: const Icon(Icons.search), onPressed: onPressed),
        IconButton(
          onPressed: onLogout,
          icon: const Icon(Icons.exit_to_app),
        ),
      ],
      automaticallyImplyLeading: false,
    );
  }
}

class _SearchAppBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPressed;

  const _SearchAppBar({
    Key? key,
    required this.onPressed,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: const Icon(Icons.search),
      title: TextField(
        autofocus: true,
        controller: controller,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: onPressed,
        )
      ],
      automaticallyImplyLeading: false,
    );
  }
}
