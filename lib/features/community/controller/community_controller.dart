import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';
import 'package:reddit/features/community/repository/community_repo.dart';
import 'package:reddit/features/models/community_model.dart';
import 'package:reddit/utils.dart';
import 'package:routemaster/routemaster.dart';

final userCommunitiesProvider= StreamProvider((ref){
  return ref.watch(communityControllerProvider.notifier).getUserCommunities();
});


final communityControllerProvider=StateNotifierProvider<CommunityController,bool>((ref){
  return CommunityController(communityRespository: ref.watch(communityRepoProvider), ref: ref);
});

class CommunityController extends StateNotifier<bool>{
  final CommunityRespository _communityRespository;
  final Ref _ref;

  CommunityController({required CommunityRespository communityRespository, required Ref ref}) : _communityRespository = communityRespository, _ref = ref, super(false);


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

Stream<List<Community>> getUserCommunities(){
  final uid=_ref.read(userProvider)!.uId;
  return _communityRespository.getUserCommunities(uid);
  }


}