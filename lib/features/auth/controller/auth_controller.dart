import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddit/features/auth/repository/auth_repo.dart';
//instead of instantiating an instance of the auth controller we will use provider
//provider will cache it hence no need for reinstantiation upon rebuild
//will also use a provider for the params of the auth repo for the same reason
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/features/models/user_model.dart';
import 'package:reddit/utils.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
// bool is the type of the state itself. In this case, it indicates that the state managed by AuthController is a boolean value.
  return AuthController(authRepository: ref.read(authRepoProvider), ref: ref);
});

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

//if you do not want to use logic in your UI that will show a circular progress indicator while signing in you can
//do it here using the state notifier class to track the state
class AuthController extends StateNotifier<bool> {
  final AuthRepo _authRepository;
  final Ref _ref;

  AuthController({required AuthRepo authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        //calling state notifier reqs some required arguments so we call super and pass it in. the arg is of type T so you decide what type to pass
        //here I want to use that state as a boolean to track whether sign in process is loading or done
        //also for clarity sake added the bool type when extending like so:StateNotifier<bool>
        //initially set to false as loading is not happening at the start
        super(false);
  Stream<User?> get authStateChange => _authRepository.authStateChange;
  void signInWithGoogle(BuildContext context) async {
    //once this func is called it means loading will start hence we will set state to true
    state = true;

    final user = await _authRepository.signInWithGoogle();
//after this user val is gotten it means sign in has completed hence loading's stopped
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) =>
          _ref.read(userProvider.notifier).update((state) => userModel),
    );
  }

  Stream<UserModel?> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }
}
