import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/failure.dart';
import 'package:reddit/features/models/user_model.dart';
import 'package:reddit/providers/firebase_providers.dart';
import 'package:reddit/type_defs.dart';

final authRepoProvider = Provider((ref) {
  return AuthRepo(
      firestore: ref.read(firestoreProvider),
      auth: ref.read(authProvider),
      googleSignIn: ref.read(googleSignInProvider));
});

class AuthRepo {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
//we used private vars so they cannot be modified so in the constructor we will assign input vals to these final vars
  AuthRepo(
      {required FirebaseFirestore firestore,
      required FirebaseAuth auth,
      required GoogleSignIn googleSignIn})
      : _firestore = firestore,
        _auth = auth,
        _googleSignIn = googleSignIn;
  CollectionReference get _users => _firestore.collection('users');
  Stream<User?> get authStateChange => _auth.authStateChanges();
  // void signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     final credential = GoogleAuthProvider.credential(
  //         accessToken: (await googleUser?.authentication)?.accessToken,
  //         idToken: (await googleUser?.authentication)?.idToken);
  //     UserCredential userCredential =
  //         await _auth.signInWithCredential(credential);
  //     print(userCredential.user?.email);
  //     var user = userCredential.user!;
  //      UserModel userModel;
  //     if (userCredential.additionalUserInfo!.isNewUser) {
  //       //this check so if the user is not new his/her data does not reset
  // userModel = UserModel(
  //     name: user.displayName ?? 'nameless',
  //     dp: user.photoURL!,
  //     banner: bannerDefault,
  //     uId: user.uid,
  //     isUser: true,
  //     karma: 0,
  //     awards: []);
  //       await _users.doc(user.uid).set(
  //           //this func takes a map so we map the props of our user to our data in the db
  //           //to avoid the plenty stress we have the to map mtd
  //           userModel.toMap());
  //     } else {
  //       //.first will give the first element of the stream
  //       userModel = await getUserData(userCredential.user!.uid).first;

  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  FutureEither<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final credential = GoogleAuthProvider.credential(
          accessToken: (await googleUser?.authentication)?.accessToken,
          idToken: (await googleUser?.authentication)?.idToken);
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      print(userCredential.user?.email);
      var user = userCredential.user!;
      UserModel? userModel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
            name: user.displayName ?? 'Lionel Messi',
            dp: user.photoURL!,
            banner: bannerDefault,
            uId: user.uid,
            isUser: true,
            karma: 0,
            awards: []);

        await _users.doc(userCredential.user!.uid).set(userModel.toMap());
      } else {
        userModel = await getUserData(userCredential.user!.uid).first;
      }
      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    //its of type Stream so we can persist the state
    return _users.doc(uid).snapshots().map(
        (event) {
print( event.data());
        return UserModel.fromMap(event.data() as Map<String, dynamic>);

        });
  }
}
