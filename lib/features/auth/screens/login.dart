import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';
import 'package:reddit/widgets/sign_in_bt.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    //line abv works cos when we defined the authProviderController as StateNotifierProvider<AuthController, bool>
    //remember it meant that the actual state of the provider was of type bool
    //hence here we get access to the provider which is what we actually we want and why we did not use the .notifier
    //the .notifier will make it of type auth controller and allow us access the funcs and props of the auth controller class
    // print(isLoading);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SignInBtn(),
              TextButton(onPressed: () {}, child: Text('Sign in as guest')),
            ],
          ),
        ),
      ),
    );
  }
}
