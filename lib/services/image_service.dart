import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();
  String? imageUrl;
  File? selectedImage;

//milih image di galeri
  Future<void> pickImage() async {
    try {
      XFile? resp = await _picker.pickImage(source: ImageSource.gallery);
      if (resp != null) {
        if (kIsWeb) {
          //web
          final bytes = await resp.readAsBytes();
          await uploadImageToFirebaseWeb(bytes, resp.name);
        } else {
          //mobile
          selectedImage = File(resp.path);
          await uploadImageToFirebase(File(resp.path));
        }
      }

    } catch (e) {
      print('Error picking image: $e');
    }
  }

  //upload ke storage (mobile)
  Future<void> uploadImageToFirebase(File image) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child("images/${DateTime.now().millisecondsSinceEpoch}.png");

      await ref.putFile(image);
      imageUrl = await ref.getDownloadURL();
      print('Upload Success (Mobile)! URL: $imageUrl');
    } catch (e) {
      print('Error uploading image (Mobile): $e');
    }
  }

  //upload ke storage (web)
  Future<void> uploadImageToFirebaseWeb(Uint8List bytes, String filename) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child("images/${DateTime.now().millisecondsSinceEpoch}_$filename");

      await ref.putData(bytes);
      imageUrl = await ref.getDownloadURL();
      print('Upload Success (Web)! URL: $imageUrl');
    } catch (e) {
      print('Error uploading image (Web): $e');
    }
  }
}
