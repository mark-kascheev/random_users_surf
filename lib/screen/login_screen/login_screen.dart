import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:random_users_surf/screen/login_screen/login_widget_model.dart';

class LoginScreen extends ElementaryWidget<LoginWidgetModel> {
  const LoginScreen(
      {Key? key,
      WidgetModelFactory<LoginWidgetModel> wmFactory = createLoginWM})
      : super(key: key, wmFactory);

  @override
  Widget build(LoginWidgetModel wm) {
    return Scaffold(
        body: Column(
      children: [
        const Spacer(),
        const _GreetingText(),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: _LoginInputField(wm)),
        const Spacer(),
        Padding(padding: const EdgeInsets.all(16), child: _LoginButton(wm: wm))
      ],
    ));
  }
}

class _GreetingText extends StatelessWidget {
  const _GreetingText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Welcome!',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
  }
}

class _LoginButton extends StatelessWidget {
  final LoginWidgetModel wm;

  const _LoginButton({
    Key? key,
    required this.wm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ValueListenableBuilder<bool>(
          valueListenable: wm.buttonEnabled,
          builder: (context, isEnabled, _) {
            return ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black),
                onPressed: isEnabled ? wm.onLoginPressed : null,
                child: const Text('Sign In', style: TextStyle(fontSize: 20)));
          }),
    );
  }
}

class _LoginInputField extends StatelessWidget {
  final LoginWidgetModel wm;

  const _LoginInputField(this.wm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: wm.loginFieldController,
      cursorColor: Colors.black,
      onSubmitted: (_) => wm.onLoginPressed(),
      decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.black, width: 1.5)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.black, width: 1.5)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.5))),
    );
  }
}
