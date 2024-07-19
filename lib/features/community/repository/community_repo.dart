
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

Stream<Community> getCommunity(String name){
  return _communities.doc(name).snapshots().map((event)=>Community.fromMap(event.data() as Map<String,dynamic>));
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

FutureVoid editCommunity(Community community)async{
  try{
    return right(_communities.doc(community.name).update(community.toMap()));

  }on FirebaseException catch(e){
    throw e.message!;
  }catch(e){
    return left(Failure(e.toString()));
  }

}

Stream<List<Community>> searchCommunity(String query) {
  return _communities
      .where(
        'name',
        isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
        isLessThan: query.isEmpty
            ? null
            : query.substring(0, query.length - 1) +
                String.fromCharCode(
                  query.codeUnitAt(query.length - 1) + 1,
                ),
      )
      .snapshots()
      .map((event) {
    List<Community> communities = [];
    for (var community in event.docs) {
      communities.add(Community.fromMap(community.data() as Map<String, dynamic>));
    }
    return communities;
  });
}

FutureVoid joinCommunity(String name,int uId)async{
  try{
    return right(_communities.doc(name).update({
      'members':FieldValue.arrayUnion([uId])
    }));

  }on FirebaseException catch(e){
    throw e.message!;
  }catch(e){
    return left(Failure(e.toString()));
  }
}
FutureVoid leaveCommunity(String name,int uId)async{
  try{
    return right(_communities.doc(name).update({
      'members':FieldValue.arrayRemove([uId])
    }));

  }on FirebaseException catch(e){
    throw e.message!;
  }catch(e){
    return left(Failure(e.toString()));
  }
}

CollectionReference get _communities=>_firestore.collection(FirebaseConstants.communitiesCollection);

}