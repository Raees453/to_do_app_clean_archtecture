import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/core/commons/extensions/build_extension.dart';
import 'package:to_do_app/core/commons/widgets/base_scaffold.dart';
import 'package:to_do_app/core/commons/widgets/text_field.dart';
import 'package:to_do_app/core/injection/dependency_injection.dart';
import 'package:to_do_app/src/auth/domain/usecases/sign_in_usecase.dart';
import 'package:to_do_app/src/auth/presentation/provider/auth_provider.dart';
import 'package:to_do_app/src/home/presentation/views/home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (kDebugMode) {
      _emailController.text = 'johndoe@mail.com';
      _passwordController.text = '123456';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                hintText: 'Enter email',
                controller: _emailController,
                title: 'Email',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hintText: 'Enter password',
                controller: _passwordController,
                title: 'Password',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _onLoginPressed,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLoginPressed() async {
    if (!_formKey.currentState!.validate()) return;

    // assume all the fields are valid
    final email = _emailController.text.trim().toLowerCase();
    final password = _passwordController.text;

    final navigator = context.navigator;
    final params = SignInParams(email: email, password: password);

    await ref.read(authStateProvider.notifier).signIn(params);

    final currentState = ref.read(authStateProvider);

    if (currentState.status == AuthStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(currentState.error ?? 'Something went wrong'),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    await instance<SharedPreferences>().setString('user', jsonEncode(currentState.user!));

    navigator.pushReplacementNamed(HomeScreen.routeName);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
