import 'dart:io';

import 'package:expense_tracker/Database/WalletDb.dart';
import 'package:expense_tracker/Errors.dart';
import 'package:expense_tracker/Models/Wallet.dart';
import 'package:expense_tracker/Services/ImageProcessService.dart';
import 'package:flutter/material.dart';

class WalletServices extends ChangeNotifier {
  Wallet? selectedWalletForForm;

  Future<bool> createNewWallet({required Wallet newWallet}) async {
    await Future.delayed(Duration(seconds: 3));
    WalletDb walletDb = await WalletDb.getDb();

    if (await _doesWalletExist(wallet: newWallet))
      throw DuplicateEntityException(
        message: "Wallet exist already",
        completionStatus: false,
      );

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
    await ImageProcessingService.deleteWalletImage(
      imagePath: selectedWalletForForm!.imageURL,
    );
    await (await WalletDb.getDb()).deleteWallet(wallet: selectedWalletForForm!);
    notifyListeners();
    return true;
  }

  Future<bool> updateWallet({required Wallet newWallet}) async {
    await Future.delayed(Duration(seconds: 3));

    if (await _doesWalletExist(wallet: newWallet))
      throw DuplicateEntityException(
        message: "Wallet already exist",
        completionStatus: false,
      );

    if (newWallet.title != selectedWalletForForm!.title) {
      selectedWalletForForm!.title = newWallet.title;
    }

    if (newWallet.imageURL == null) {
      await ImageProcessingService.deleteWalletImage(
        imagePath: selectedWalletForForm!.imageURL,
      );
      selectedWalletForForm!.imageURL = null;
    } else if (newWallet.imageURL != selectedWalletForForm!.imageURL) {
      String sameOrNewPath = await ImageProcessingService.saveWalletImage(
        tempImageUrl: newWallet.imageURL!,
        walletKey: selectedWalletForForm!.key,
      );
      selectedWalletForForm!.imageURL = sameOrNewPath;
      await FileImage(File(sameOrNewPath)).evict();
    }

    (await WalletDb.getDb()).update(wallet: selectedWalletForForm!);

    notifyListeners();
    return true;
  }

  Future<bool> _doesWalletExist({required Wallet wallet}) async {
    String title = wallet.title;

    List<Wallet> walletList = await getAllWallets();

    Wallet walletInList = walletList.firstWhere(
      (wallet) => wallet.title == title,
      orElse: () => Wallet(title: "", totalAmount: 0),
    );

    return walletInList.title.isNotEmpty;
  }

  Future<double> getTotalBalance() async {
    final list = await getAllWallets();
    double total = 0;
    list.forEach((wallet) => total += wallet.totalAmount);

    return total;
  }

  Future<List<Wallet>> getAllWallets() async {
    await Future.delayed(Duration(seconds: 2));
    WalletDb walletDb = await WalletDb.getDb();

    List<Wallet> walletList = walletDb.getWalletList();
    return walletList;
  }
}
