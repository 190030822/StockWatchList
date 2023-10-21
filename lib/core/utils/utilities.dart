
import 'dart:async';

Timer? _debounce;
String preValue = "";
debounce(String value, dynamic Function() callback) {
  if (_debounce?.isActive ?? false) {
    _debounce!.cancel();
  }
  if (preValue != value) {
    _debounce = Timer(const Duration(milliseconds: 1500), () {
      callback();
      preValue = value;
    });
  }
}