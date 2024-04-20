import 'package:flutter/material.dart';

final class EmailFormField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onFieldSubmitted;

  const EmailFormField({super.key, this.controller, this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
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
