import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class VideoPicker {
  String? videoUrl;

  Future<void> pickVideo() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp4', 'mov', 'avi', 'mkv'],
      );

      if (result != null && result.files.single.path != null) {
        File videoFile = File(result.files.single.path!);
        await uploadVideo(videoFile);
      }
    } catch (e) {
      print('Error picking video: $e');
    }
  }

  Future<void> uploadVideo(File videoFile) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child("videos/${DateTime.now().millisecondsSinceEpoch}.mp4");

      await ref.putFile(videoFile);
      videoUrl = await ref.getDownloadURL();
      print('Video uploaded: $videoUrl');
    } catch (e) {
      print('Error uploading video: $e');
    }
  }
}
