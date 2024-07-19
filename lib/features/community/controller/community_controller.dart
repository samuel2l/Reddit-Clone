import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/failure.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';
import 'package:reddit/features/community/repository/community_repo.dart';
import 'package:reddit/features/models/community_model.dart';
import 'package:reddit/providers/storage_repository_providers.dart';
import 'package:reddit/type_defs.dart';
import 'package:reddit/utils.dart';
import 'package:routemaster/routemaster.dart';

final userCommunitiesProvider= StreamProvider<List<Community>>((ref){
  return ref.watch(communityControllerProvider.notifier).getUserCommunities();
});
final searchCommunityProvider = StreamProvider.family((ref, String query) {
  return ref.watch(communityControllerProvider.notifier).searchCommunity(query);
});

final communityControllerProvider=StateNotifierProvider<CommunityController,bool>((ref){
  return CommunityController(communityRespository: ref.watch(communityRepoProvider), ref: ref,storageRepository: ref.watch(firebaseStorageProvider));
});

final getCommunityProvider=StreamProvider.family((ref,String name) {
  return ref.watch(communityControllerProvider.notifier).getCommunity(name);
});
class CommunityController extends StateNotifier<bool>{
  final CommunityRespository _communityRespository;
  final Ref _ref;
  final StorageRepository _storageRepository;

  CommunityController({required CommunityRespository communityRespository, required Ref ref, required StorageRepository storageRepository}) : _communityRespository = communityRespository, _ref = ref, _storageRepository = storageRepository,super(false);



void createCommunity(String name, BuildContext context) async {
state=true;
final uid=_ref.read(userProvider)?.uId??'';
Community community=Community(id: uid, name: name, banner: bannerDefault, dp: avatarDefault, members:[uid], mods: [uid]); 
final res=await _communityRespository.createCommunity(community);
state=false;
res.fold((l) => showSnackBar(context,l.message), (r) {
  showSnackBar(context, 'Succcessful creation');
  Routemaster.of(context).pop();
});
}

Stream<Community> getCommunity(String name){
  return _communityRespository.getCommunity(name);
}

Stream<List<Community>> getUserCommunities(){
  final uid=_ref.read(userProvider)!.uId;
  return _communityRespository.getUserCommunities(uid);
  }

void editCommunity({
  required Community community,
  required File? banner,
  required File? dp,
  required BuildContext context,
}) async {
  state = true;
  String? dpUrl;
  String? bannerUrl;

  if (dp != null) {
    final res = await _storageRepository.storeFile(
      path: 'communities/profile',
      id: community.name,
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
      path: 'communities/banner',
      id: community.name,
      file: banner,
    );
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        bannerUrl = r;
      },
    );
  }

  final updatedCommunity = community.copyWith(
    dp: dpUrl ?? community.dp,
    banner: bannerUrl ?? community.banner,
  );

  final res = await _communityRespository.editCommunity(updatedCommunity);
  state = false;
  res.fold(
    (l) => showSnackBar(context, l.message),
    (r) => Routemaster.of(context).pop(),
  );
}
  Stream<List<Community>> searchCommunity(String query) {
    return _communityRespository.searchCommunity(query);
  }


void joinCommunity(Community community,BuildContext context)async{
  final user=_ref.read(userProvider)!;
  Either<Failure,void> res;
  if (community.members.contains(user.uId)){
    res=await _communityRespository.leaveCommunity(community.name, user.uId as int);
  }else{
   res=await _communityRespository.joinCommunity(community.name, user.uId as int);
    
  }
res.fold((l) => showSnackBar(context,l.message), (r) {
if (community.members.contains(user.uId)){
showSnackBar(context, 'Community joined successfully');
}else{
  showSnackBar(context, 'Community left successfully');
}
});

}

}

