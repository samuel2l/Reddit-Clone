import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';

class SignInBtn extends ConsumerWidget {
  const SignInBtn({super.key});
  void signInWithGoogle(WidgetRef ref,context) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
        onPressed: () {
          signInWithGoogle(ref,context);
        },
        child: const Text('Continue with Google'));
  }
}
