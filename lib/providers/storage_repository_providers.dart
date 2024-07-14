import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit/failure.dart';
import 'package:reddit/providers/firebase_providers.dart';
import 'package:reddit/type_defs.dart';
final firebaseStorageProvider=Provider((ref) => StorageRepository(firebaseStorage: ref.watch(storageProvider)));

class StorageRepository{
  final FirebaseStorage _firebaseStorage;

  StorageRepository({required FirebaseStorage firebaseStorage}) : _firebaseStorage = firebaseStorage;

FutureEither<String> storeFile({required String path,required String id, required File? file})async{
 try{
  final ref= _firebaseStorage.ref().child(path).child(id);
  UploadTask uploadTask=ref.putFile(file!);
  final snapshot=await uploadTask;
  return right(await snapshot.ref.getDownloadURL());
// - **Create a Storage Reference**: 
//   final ref = _firebaseStorage.ref().child(path).child(id);
//   - This creates a reference to the location in Firebase Storage where the file will be stored.
//   - `_firebaseStorage.ref()`: The root reference of Firebase Storage.
//   - `.child(path)`: A child reference under the root, specified by the `path` parameter.
//   - `.child(id)`: A child reference under the path, specified by the `id` parameter.

//   - `ref.putFile(file!)`: Starts uploading the file to the specified reference
//   - `UploadTask`: Represents the task of uploading the file.
//   final snapshot = await uploadTask;
//   - This line waits for the upload task to complete and obtains the snapshot of the upload.

// - **Return the Download URL**:
//   return right(await snapshot.ref.getDownloadURL());
//   - `snapshot.ref.getDownloadURL()`: Gets the download URL of the uploaded file.
//   - `right(await snapshot.ref.getDownloadURL())`: Wraps the download URL in a `Right` to indicate a successful operation.

 }catch(e){
  return left(Failure(e.toString()));
 } 
}
}