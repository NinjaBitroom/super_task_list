import 'package:flutter/material.dart';

class RestartButton extends StatelessWidget {
  final void Function() onPressed;

  const RestartButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.restart_alt),
    );
  }
}
