import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';
import 'package:reddit/features/models/user_model.dart';
import 'package:reddit/firebase_options.dart';
import 'package:reddit/routes.dart';
import 'package:reddit/themes/pallette.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;
  bool isLoading = false;

  Future<void> getData(WidgetRef ref, User data) async {
    setState(() {
      isLoading = true;
    });
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
      data: (data) {
        if (data != null && userModel == null && !isLoading) {
          // Fetch user data only if it's not already fetched and not currently loading
          getData(ref, data);
        }

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          title: 'Reddit Tutorial',
          routerDelegate: RoutemasterDelegate(
            routesBuilder: (context) {
              if (data != null && userModel != null) {
                // User is signed in and user data is fetched
                print('USER NOT NULL');
                return loggedInRoutes;
              } else {
                // User is not signed in
                return loggedOutRoutes;
              }
            },
          ),
          routeInformationParser: const RoutemasterParser(),
        );
      },
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
      
    );
  }
}
