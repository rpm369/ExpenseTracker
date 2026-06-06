import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageProcessingService {
  static Future<String?> getImageFromUser() async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      return (image == null) ? null : image.path;
    } catch (e) {}
  }

  static Future<String> saveUserImage({
    required String tempImageUrl,
    required int userKey,
  }) async {
    String docDirPath = (await getApplicationDocumentsDirectory()).path;
    String imageDirPath = path.join(docDirPath, 'userImages');

    Directory imageDir = Directory(imageDirPath);

    if (!(await imageDir.exists())) {
      await imageDir.create(recursive: true);
    }

    String targetPath = path.join(imageDirPath, "${userKey.toString()}.png");

    File targetFile = await File(tempImageUrl).copy(targetPath);
    return targetFile.path;
  }
}

enum FileConstants {
  IMAGE_DIR("userImages");

  final String id;
  const FileConstants(this.id);
}
