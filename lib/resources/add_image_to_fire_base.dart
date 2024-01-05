// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart' as firebase_st;

final firebase_st.FirebaseStorage storage =
    firebase_st.FirebaseStorage.instance;
// storage.setCustomStorageBucket('gs://your-project-id.appspot.com');

class StoreImage {
  static Future<String> uploadImageToStorage(
      {required Uint8List img, required String imgnName}) async {
    // imgnName = DateTime.now().millisecond.toString();

    try {
      final ref = storage.ref('images/$imgnName');
      await ref.putData(
          img, firebase_st.SettableMetadata(contentType: 'image/jpg'));
      // Retrieve the download URL after the image is uploaded
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }
}
