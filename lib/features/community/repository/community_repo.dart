import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit/constants/firebase_constants.dart';
import 'package:reddit/failure.dart';
import 'package:reddit/features/models/community_model.dart';
import 'package:reddit/type_defs.dart';

class CommunityRespository{
final FirebaseFirestore _firestore;

  CommunityRespository({required FirebaseFirestore firestore}) : _firestore = firestore;

FutureVoid createCommunity(Community community) async {
try{
  var name= await _communities.doc(community.name).get();
  if (name.exists){
    throw 'Community name already taken';
  }
  return right(await _communities.doc(community.name).set(community.toMap()));
} on FirebaseException catch(e){
  throw e.message!;
}catch(e){
  return left(Failure(e.toString()));
}
  
}

CollectionReference get _communities=>_firestore.collection(FirebaseConstants.communitiesCollection);

}