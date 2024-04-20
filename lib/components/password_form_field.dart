import 'package:flutter/material.dart';

final class PasswordFormField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final String? labelText;

  const PasswordFormField({
    super.key,
    this.controller,
    this.onFieldSubmitted,
    this.focusNode,
    this.autofillHints,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    final currentFocusNode = focusNode ?? FocusNode();
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      autofillHints: autofillHints,
      obscureText: true,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText ?? 'Senha',
        prefixIcon: const Icon(Icons.password),
      ),
      focusNode: currentFocusNode,
      onFieldSubmitted: onFieldSubmitted,
      onTapOutside: (event) {
        currentFocusNode.unfocus();
      },
    );
  }
}
