import 'package:shared_preferences/shared_preferences.dart';

class StringStorage {
  StringStorage({required this.key});

  static String? _value;
  final String key;

  Future<String?> get() async {
    if (_value != null) {
      return _value;
    }

    return _value = (await SharedPreferences.getInstance()).getString(key);
  }

  Future<void> set(String value) async {
    if (await (await SharedPreferences.getInstance()).setString(key, value)) {
      _value = value;
    }
  }

  Future<void> purge() async {
    if (await (await SharedPreferences.getInstance()).remove(key)) {
      _value = null;
    }
  }
}

class DoubleStorage {
  DoubleStorage({required this.key});

  static double? _value;
  final String key;

  Future<double?> get() async {
    if (_value != null) {
      return _value;
    }

    return _value = (await SharedPreferences.getInstance()).getDouble(key);
  }

  Future<void> set(double value) async {
    if (await (await SharedPreferences.getInstance()).setDouble(key, value)) {
      _value = value;
    }
  }

    Future<void> purge() async {
    if (await (await SharedPreferences.getInstance()).remove(key)) {
      _value = null;
    }
  }
}

class IntStorage {
  IntStorage({required this.key});

  static int? _value;
  final String key;

  Future<int?> get() async {
    if (_value != null) {
      return _value;
    }

    return _value = (await SharedPreferences.getInstance()).getInt(key);
  }

  Future<void> set(int value) async {
    if (await (await SharedPreferences.getInstance()).setInt(key, value)) {
      _value = value;
    }
  }

  Future<void> purge() async {
    if (await (await SharedPreferences.getInstance()).remove(key)) {
      _value = null;
    }
  }
}

class BoolStorage {
  BoolStorage({required this.key});

  static bool? _value;
  final String key;

  Future<bool?> get() async {
    if (_value != null) {
      return _value;
    }

    return _value = (await SharedPreferences.getInstance()).getBool(key);
  }

  Future<void> set(bool value) async {
    if (await (await SharedPreferences.getInstance()).setBool(key, value)) {
      _value = value;
    }
  }

  Future<void> purge() async {
    if (await (await SharedPreferences.getInstance()).remove(key)) {
      _value = null;
    }
  }
}
