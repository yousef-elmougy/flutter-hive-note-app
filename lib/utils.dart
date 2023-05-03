import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static String toDateTime(DateTime dateTime) {
    final date = DateFormat.yMd().format(dateTime);
    final time = DateFormat.jm().format(dateTime);

    return '$date - $time';
  }

  static void snackBar(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 2000),
          content: Text(message),
        ),
      );
}
