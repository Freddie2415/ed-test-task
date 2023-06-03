import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  final String message;

  const FailureWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        message,
        textAlign: TextAlign.center,
      ),
    );
  }
}
