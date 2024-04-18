import 'package:flutter/material.dart';

class EmailFormField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onFieldSubmitted;

  const EmailFormField({super.key, this.controller, this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      controller: controller,
      decoration: const InputDecoration(labelText: 'E-mail'),
      autofocus: true,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}