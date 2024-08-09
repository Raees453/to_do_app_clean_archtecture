import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/core/commons/extensions/build_extension.dart';
import 'package:to_do_app/src/auth/presentation/provider/auth_provider.dart';

class ProfileScreenWidget extends ConsumerWidget {
  const ProfileScreenWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).user;

    if (user == null) {
      return Center(
        child: Text(
          'Please login to access this screen',
          style: context.textTheme.bodyLarge,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Id: ${user.id}', style: context.textTheme.bodyLarge),
        const SizedBox(height: 8),
        Text('Display Name: ${user.name}', style: context.textTheme.bodyLarge),
        const SizedBox(height: 8),
        Text('Email: ${user.email}', style: context.textTheme.bodyLarge),
      ],
    );
  }
}
