import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:random_users_surf/screen/login_screen/login_widget_model.dart';

class LoginScreen extends ElementaryWidget<LoginWidgetModel> {
  const LoginScreen({
    Key? key,
    WidgetModelFactory<LoginWidgetModel> wmFactory = createLoginWM,
  }) : super(key: key, wmFactory);

  @override
  Widget build(LoginWidgetModel wm) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          const _GreetingText(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: _LoginInputField(
              controller: wm.loginFieldController,
              onSubmitted: wm.onLoginPressed,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _LoginButton(
              onPressed: wm.onLoginPressed,
              buttonEnabled: wm.buttonEnabled,
            ),
          ),
        ],
      ),
    );
  }
}

class _GreetingText extends StatelessWidget {
  const _GreetingText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Welcome!',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final ValueListenable<bool> buttonEnabled;
  final VoidCallback onPressed;

  const _LoginButton({
    required this.buttonEnabled,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ValueListenableBuilder<bool>(
        valueListenable: buttonEnabled,
        builder: (context, isEnabled, _) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.black),
            onPressed: isEnabled ? onPressed : null,
            child: const Text('Sign In', style: TextStyle(fontSize: 20)),
          );
        },
      ),
    );
  }
}

class _LoginInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmitted;

  const _LoginInputField({
    required this.controller,
    required this.onSubmitted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      onSubmitted: (_) => onSubmitted(),
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.5),
        ),
      ),
    );
  }
}
