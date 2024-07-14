import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/constants/constants.dart';
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

void editCommunity({required Community community,required File? banner,required File? dp,required BuildContext context})async{
 if(dp!=null){
  final res=await _storageRepository.storeFile(path: 'communities/profile', id: community.name, file: dp);
 res.fold((l) => showSnackBar(context, l.message), (r) => community.copyWith(dp:r))
; }
if(banner!=null){
  final res=await _storageRepository.storeFile(path: 'communities/profile', id: community.name, file: banner);
 res.fold((l) => showSnackBar(context, l.message), (r) => community.copyWith(banner:r))
; }
final res=await _communityRespository.editCommunity(community);
 res.fold((l) => showSnackBar(context, l.message), (r) => Routemaster.of(context).pop());
}
}

