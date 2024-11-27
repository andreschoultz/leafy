import 'package:flutter/foundation.dart';

class GlobalModel extends ChangeNotifier {
  GlobalModel(); 

  bool _isLoading = false;
  bool _isError = false;
  String? _message;

  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String? get message => _message;

  void setLoading({bool value = true}) {
    _isLoading = value;
    
    notifyListeners();
  }

  void setError(bool value, {String? message}) {
    _isError = value;
    _message = message ?? _message;

    notifyListeners();
  }

  void setMessage(String message) {
    _message = message;

    notifyListeners();
  }

  void clearMessage() {
    _message = null;

    notifyListeners();
  }
}