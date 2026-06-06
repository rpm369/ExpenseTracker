import 'dart:io';

import 'package:expense_tracker/Database/WalletDb.dart';
import 'package:expense_tracker/Models/Wallet.dart';
import 'package:expense_tracker/Services/ImageProcessService.dart';
import 'package:flutter/material.dart';

class WalletServices extends ChangeNotifier {
  Wallet? selectedWalletForForm;

  Future<bool> createNewWallet({required Wallet newWallet}) async {
    await Future.delayed(Duration(seconds: 3));
    WalletDb walletDb = await WalletDb.getDb();

    int key = await walletDb.addNewWallet(wallet: newWallet);
    newWallet.id = key;

    if (newWallet.imageURL != null) {
      String imageNewPath = await ImageProcessingService.saveWalletImage(
        tempImageUrl: newWallet.imageURL!,
        walletKey: key,
      );
      newWallet.imageURL = imageNewPath;
    }

    await walletDb.update(wallet: newWallet);
    notifyListeners();
    return true;
  }

  Future<bool> deleteSelectedWallet() async {
    await Future.delayed(Duration(seconds: 3));
    await (await WalletDb.getDb()).deleteWallet(wallet: selectedWalletForForm!);
    notifyListeners();
    return true;
  }

  Future<bool> updateWallet({required Wallet newWallet}) async {
    await Future.delayed(Duration(seconds: 3));

    bool needToUpdate = false;

    if (newWallet.title != selectedWalletForForm!.title) {
      selectedWalletForForm!.title = newWallet.title;
      needToUpdate = true;
    }
    if (newWallet.imageURL != selectedWalletForForm!.imageURL) {
      String samePath = await ImageProcessingService.saveWalletImage(
        tempImageUrl: newWallet.imageURL!,
        walletKey: selectedWalletForForm!.key,
      );
      await FileImage(File(samePath)).evict();
      //update is not require since only the content is changed and not the path+image on the disk.
    }

    if (needToUpdate)
      (await WalletDb.getDb()).update(wallet: selectedWalletForForm!);

    notifyListeners();
    return true;
  }

  Future<double> getTotalBalance() async {
    final list = await getAllWallets();
    double total = 0;
    list.forEach((wallet) => total += wallet.totalAmount);

    return total;
  }

  Future<List<Wallet>> getAllWallets() async {
    await Future.delayed(Duration(seconds: 3));
    WalletDb walletDb = await WalletDb.getDb();

    List<Wallet> walletList = walletDb.getWalletList();
    return walletList;
  }
}
