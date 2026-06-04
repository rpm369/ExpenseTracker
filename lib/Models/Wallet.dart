class Wallet {
  String _title;
  double _totalAmount;
  String? _imageURL;

  Wallet({required this._title, required this._totalAmount, this._imageURL});

  set title(String newTitle) => this._title = newTitle;
  set totalAmount(double newAmount) => this._totalAmount = newAmount;
  set imageURL(String newURL) => this._imageURL = newURL;

  String get title => this._title;
  double get totalAmount => this._totalAmount;
  String? get imageURL => this._imageURL;
}
