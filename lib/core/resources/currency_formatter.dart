import 'package:flutter/services.dart';

class NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String enteredData = newValue.text;
    StringBuffer buffer = StringBuffer();
    bool hasDecimal = false; // flag to track if decimal point added

    for (int i = 0; i < enteredData.length; i++) {
      final char = enteredData[i];

      // Check if character is a digit (0-9) or decimal point (.)
      if (RegExp(r'[0-9.]').hasMatch(char.toString())) {
        buffer.write(char);

        // Add decimal point only if it hasn't been added yet
        if (char == '.' && !hasDecimal) {
          hasDecimal = true;
        }
      }

      int index = i + 1;
      // Add comma after every 3rd digit (excluding if decimal added)
      if (index % 3 == 0 && enteredData.length != index && !hasDecimal) {
        buffer.write(',');
      }
    }

    // Handle trailing comma (for single digit or numbers ending with decimal)
    if (buffer.toString().endsWith(',') && (buffer.length == 2 || buffer.toString().endsWith('.,'))) {
      buffer.toString().substring(0, buffer.length - 1);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.toString().length),
    );
  }
}


