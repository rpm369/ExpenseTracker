import 'dart:io';

import 'package:image_picker/image_picker.dart';

class FilePickerService {
  static Future<File?> getFileFromUser() async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      return (image == null) ? null : File(image.path);
    } catch (e) {}
  }
}
