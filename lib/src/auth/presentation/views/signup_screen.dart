import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/core/commons/extensions/build_extension.dart';
import 'package:to_do_app/core/commons/widgets/base_scaffold.dart';
import 'package:to_do_app/core/commons/widgets/text_field.dart';
import 'package:to_do_app/src/auth/domain/usecases/sign_up_usecase.dart';
import 'package:to_do_app/src/auth/presentation/provider/auth_provider.dart';
import 'package:to_do_app/src/auth/presentation/views/login_screen.dart';

class SignupScreen extends ConsumerStatefulWidget {
  static const String routeName = '/sign-up';

  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (kDebugMode) {
      _nameController.text = 'John Doe';
      _emailController.text = 'johndoe@mail.com';
      _passwordController.text = '123456';
      _confirmPasswordController.text = '123456';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return BaseScaffold(
      child: authState.status == AuthStatus.loading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: context.height * 0.05),
                    Text(
                      'Signup',
                      style: context.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: context.height * 0.05),
                    CustomTextField(
                      hintText: 'Enter your name',
                      controller: _nameController,
                      title: 'Full Name',
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
                    CustomTextField(
                      hintText: 'Enter confirm password',
                      controller: _confirmPasswordController,
                      title: 'Confirm Password',
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(onPressed: _onSignupPressed, child: const Text('Signup')),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _onSignupPressed() async {
    if (!_formKey.currentState!.validate()) return;

    // assumes that all fields are valid
    final name = _nameController.text.trim();
    final email = _emailController.text.trim().toLowerCase();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    final navigator = context.navigator;
    final params = SignUpParams(name: name, email: email, password: password);

    await ref.read(authStateProvider.notifier).signUp(params);

    final currentState = ref.read(authStateProvider);

    if (currentState.status == AuthStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(currentState.error ?? 'Some Error Occurred'),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    navigator.pushReplacementNamed(LoginScreen.routeName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
