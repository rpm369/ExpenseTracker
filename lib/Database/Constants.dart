enum SystemDbConst {
  IS_DARK("isDark"),
  LOGGED_USER_ID("loggedUID");

  final String id;
  const SystemDbConst(this.id);
}

enum UserDbConst {
  DB_NAME("UserDbBox");

  final String id;
  const UserDbConst(this.id);
}

enum TransactionDbConsts {
  DB_NAME("Transaction_");

  final String id;
  const TransactionDbConsts(this.id);
}

enum WalletDbConst {
  DB_NAME("Wallet_");

  final String id;
  const WalletDbConst(this.id);
}
