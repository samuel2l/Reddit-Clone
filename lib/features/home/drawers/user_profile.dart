import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';
import 'package:routemaster/routemaster.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void signOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).signOut();
  }

  void navigateToUserProfile(BuildContext context, String uid) {
    Routemaster.of(context).push('/u/$uid');
  }

  // void toggleTheme(WidgetRef ref) {
  //   ref.read(themeNotifierProvider.notifier).toggleTheme();
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.dp),
              radius: 70,
            ),
            const SizedBox(height: 10),
            Text(
              'u/${user.name}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            ListTile(
              title: const Text('My Profile'),
              leading: const Icon(Icons.person),
              onTap: () => navigateToUserProfile(context, user.uId),
            ),
            ListTile(
              title: const Text('Log Out'),
              leading: const Icon(
                Icons.logout,
              ),
              onTap: () => signOut(ref),

            ),
            Switch.adaptive(value: true, onChanged:(val){},)
          ],
        ),),
    );
  }
}