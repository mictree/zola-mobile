import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    }

    return File(image.path);
  }

  static Future<File?> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }

    return File(image.path);
  }

  static Future<File?> pickVideoFromCamera() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    if (video == null) {
      return null;
    }

    return File(video.path);
  }

  static Future<File?> pickVideoFromGallery() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video == null) {
      return null;
    }

    return File(video.path);
  }

}
