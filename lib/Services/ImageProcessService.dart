import 'dart:io';

import 'package:expense_tracker/Services/UserService.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageProcessingService {
  static Future<String?> getImageFromUser() async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      return (image == null) ? null : image.path;
    } catch (e) {
      return null;
    }
  }

  static Future<String> saveWalletImage({
    required String tempImageUrl,
    required int walletKey,
  }) async {
    String docDirPath = (await getApplicationDocumentsDirectory()).path;
    String walletDirPath = path.join(docDirPath, FileConstants.WALLET_DIR.id);

    Directory walletDir = Directory(walletDirPath);

    if (!(await walletDir.exists())) {
      await walletDir.create(recursive: true);
    }

    int userId = UserService().getActiveUser().key;
    String targetImageName =
        "${userId}${walletKey}${FileConstants.IMAGE_EXTENSION.id}";

    String targetPath = path.join(walletDirPath, targetImageName);

    File targetFile = await File(tempImageUrl).copy(targetPath);
    return targetFile.path;
  }

  static Future<void> deleteWalletImage({required String? imagePath}) async {
    if (imagePath == null) return;
    File walletImage = File(imagePath);

    if (await walletImage.exists()) {
      await walletImage.delete();
    }
  }

  static Future<String> saveUserImage({
    required String tempImageUrl,
    required int userKey,
  }) async {
    String docDirPath = (await getApplicationDocumentsDirectory()).path;
    String imageDirPath = path.join(
      docDirPath,
      FileConstants.USER_IMAGE_DIR.id,
    );

    Directory imageDir = Directory(imageDirPath);

    if (!(await imageDir.exists())) {
      await imageDir.create(recursive: true);
    }

    String targetPath = path.join(
      imageDirPath,
      "${userKey.toString()}${FileConstants.IMAGE_EXTENSION.id}",
    );

    File targetFile = await File(tempImageUrl).copy(targetPath);
    return targetFile.path;
  }
}

enum FileConstants {
  USER_IMAGE_DIR("userImages"),
  IMAGE_EXTENSION(".png"),
  WALLET_DIR("wallets");

  final String id;
  const FileConstants(this.id);
}
