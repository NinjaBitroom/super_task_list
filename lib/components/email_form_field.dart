import 'package:flutter/material.dart';

final class EmailFormField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;

  const EmailFormField(
      {super.key,
      this.controller,
      this.onFieldSubmitted,
      this.textInputAction});

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      textInputAction: textInputAction ?? TextInputAction.next,
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'E-mail',
        prefixIcon: Icon(Icons.email),
      ),
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      onTapOutside: (event) {
        focusNode.unfocus();
      },
    );
  }
}
