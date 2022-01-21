import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class InputController extends TextEditingController {
  String? _error;
  bool _disabled = false;
  bool _loading;
  String? _success;
  String? _prefixText;

  InputController(
      {String text = "",
      String? error,
      String? success,
      bool disabled = false,
      bool loading = false,
      String? prefixText})
      : _error = error,
        _disabled = disabled,
        _loading = loading,
        _success = success,
        _prefixText = prefixText,
        super(text: text);

  String? get error => _error;
  bool get disabled => _disabled;
  bool get loading => _loading;
  String? get success => _success;
  String? get prefixText => _prefixText;

  set error(String? err) {
    if (_error == err) return;
    _error = err;
    notifyListeners();
  }

  set prefixText(String? prefixText) {
    if (_prefixText == prefixText) return;
    _prefixText = prefixText;
    notifyListeners();
  }

  void clearError() => error = null;
  set loading(bool loading) {
    if (loading == _loading) return;
    _loading = loading;
    notifyListeners();
  }

  set disabled(bool disabled) {
    if (_disabled == disabled) return;
    _disabled = disabled;
    notifyListeners();
  }

  set success(String? success) {
    if (_success == success) return;
    _success = success;
    notifyListeners();
  }
}
