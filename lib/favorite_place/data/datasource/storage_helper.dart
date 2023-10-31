import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageHelper {
  Future<String?> uploadImageFromFile(File file);
}

class StorageHelperImp implements StorageHelper {
  @override
  Future<String?> uploadImageFromFile(File file) async {
    final storageRef = FirebaseStorage.instance.ref();
    final uploadTask = storageRef
        .child("PLacesImages/${file.path.split('/').last}")
        .putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete((){});
      if (taskSnapshot.state == TaskState.running) {
        final progress =
            100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
        print("Upload is $progress% complete.");
      } else if (taskSnapshot.state == TaskState.error) {
        throw Exception('Failed to upload image');
      } else if (taskSnapshot.state == TaskState.success) {
        final url = await taskSnapshot.ref.getDownloadURL();
        print(url);
        return url;
      }
  }
}
