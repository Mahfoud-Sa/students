import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorMessage extends StatelessWidget {
  final message;
  const ErrorMessage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
        showCloseIcon: true,
        backgroundColor: Colors.green,
        content: Text('$message'));
    ;
  }
}
