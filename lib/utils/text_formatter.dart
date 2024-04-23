
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Jika nilai baru tidak ada atau kosong, kembalikan nilai lama
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Parse nilai baru sebagai angka
    final parsed = int.tryParse(newValue.text) ?? 0;

    // Format angka sebagai mata uang
    final newString =  NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(parsed);

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
    );
  }
}
