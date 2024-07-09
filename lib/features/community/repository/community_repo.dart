import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit/constants/firebase_constants.dart';
import 'package:reddit/failure.dart';
import 'package:reddit/features/models/community_model.dart';
import 'package:reddit/providers/firebase_providers.dart';
import 'package:reddit/type_defs.dart';
final communityRepoProvider=Provider((ref) => CommunityRespository(firestore: ref.watch(firestoreProvider)));
class CommunityRespository{
final FirebaseFirestore _firestore;

  CommunityRespository({required FirebaseFirestore firestore}) : _firestore = firestore;


FutureVoid createCommunity(Community community) async {
try{
  var name= await _communities.doc(community.name).get();
  if (name.exists){
    throw 'Community name already taken';
  }
  return right( _communities.doc(community.name).set(community.toMap()));
} on FirebaseException catch(e){
  throw e.message!;
}catch(e){
  return left(Failure(e.toString()));
}
  
}
Stream<List<Community>> getUserCommunities(String uid){
  //the .snapshots returns stream of query obj. so we map elements in that stream to our user community model
  return _communities.where('members',arrayContains: uid).snapshots().map((event){
    List<Community> communities=[];
    for(var doc in event.docs){
      communities.add(Community.fromMap(doc.data() as Map<String,dynamic>));
    }
    return communities;
  });
}
CollectionReference get _communities=>_firestore.collection(FirebaseConstants.communitiesCollection);

}