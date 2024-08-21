import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';
import 'package:reddit/features/user%20profile/repository/user_profile_repo.dart';
import 'package:reddit/providers/firebase_providers.dart';
import 'package:reddit/providers/storage_repository_providers.dart';
import 'package:reddit/utils.dart';
import 'package:routemaster/routemaster.dart';
final userProfileRepoProvider=Provider((ref) => UserProfileRepository(firestore: ref.watch(firestoreProvider)));

final userProfileControllerProvider=StateNotifierProvider<UserProfileController,bool>((ref){
  return UserProfileController(userProfileRepository: ref.watch(userProfileRepoProvider), ref: ref,storageRepository: ref.watch(firebaseStorageProvider));
});

class UserProfileController extends StateNotifier<bool>{
  final UserProfileRepository _userProfileRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;


  UserProfileController({required UserProfileRepository userProfileRepository, required Ref ref, required StorageRepository storageRepository}) : _userProfileRepository = userProfileRepository, _ref = ref, _storageRepository = storageRepository,super(false);

void editUserProfile({

  required File? banner,
  required File? dp,
  required BuildContext context,
  required String name
}) async {
  state = true;
  final user = _ref.read(userProvider)!;
  String? dpUrl;
  String? bannerUrl;

  if (dp != null) {
    final res = await _storageRepository.storeFile(
      path: 'users/profile',
      id: user.uId,
      file: dp,
    );
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        //if the file was successfully stored in firebase then set the dp url to the result
        //the result,res, is basicaly the link to the dp hence the dp url
        dpUrl = r;
      },
    );
  }

  if (banner != null) {
    final res = await _storageRepository.storeFile(
      path: 'users/banner',
      id: user.uId,
      file: banner,
    );
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        bannerUrl = r;
      },
    );
  }

  final updatedUserProfile = user.copyWith(
    dp: dpUrl ?? user.dp,
    banner: bannerUrl ?? user.banner,
    name: name
  );

  final res = await _userProfileRepository.editUserProfile(updatedUserProfile);
  state = false;
  res.fold( 
    (l) => showSnackBar(context, l.message),
    (r) => Routemaster.of(context).pop(),
  );
}

}
