import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit/constants/firebase_constants.dart';
import 'package:reddit/failure.dart';

import 'package:reddit/features/models/user_model.dart';
import 'package:reddit/type_defs.dart';

class UserProfileRepository{
  final FirebaseFirestore _firestore;

UserProfileRepository({required FirebaseFirestore firestore}) : _firestore = firestore;

FutureVoid editUserProfile(UserModel user)async{
  try{
    return right(_user.doc(user.uId).update(user.toMap()));

  }on FirebaseException catch(e){
    throw e.message!;
  }catch(e){
    return left(Failure(e.toString()));
  }

}

CollectionReference get _user=>_firestore.collection(FirebaseConstants.usersCollection);

}