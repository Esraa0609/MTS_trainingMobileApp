import 'package:flutter/services.dart';

class LimitedDigitsInputFormatter extends TextInputFormatter {
  final int maxDigits;

  LimitedDigitsInputFormatter({this.maxDigits = 3});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Allow only digits and limit the length
    String newText = newValue.text;
    if (newText.length > maxDigits) {
      newText = newText.substring(0, maxDigits);
    }
    return newValue.copyWith(
      text: newText,
      selection: newValue.selection.copyWith(
        baseOffset: newText.length,
        extentOffset: newText.length,
      ),
    );
  }
}
