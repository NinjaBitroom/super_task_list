import 'package:flutter/material.dart';

final class BasePage extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? leading;
  final bool? automaticallyImplyLeading;
  final Widget? floatingActionButton;

  const BasePage({
    super.key,
    required this.title,
    required this.child,
    this.leading,
    this.automaticallyImplyLeading,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading ?? true,
        leading: leading,
        title: Text(title),
      ),
      body: child,
      floatingActionButton: floatingActionButton,
    );
  }
}
