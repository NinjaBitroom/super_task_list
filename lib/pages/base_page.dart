import 'package:flutter/material.dart';

final class BasePage extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? leading;
  final bool? automaticallyImplyLeading;
  final Widget? floatingActionButton;
  final List<Widget>? actions;

  const BasePage({
    super.key,
    required this.title,
    required this.child,
    this.leading,
    this.automaticallyImplyLeading,
    this.floatingActionButton,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading ?? true,
        leading: leading,
        title: Text(title),
        actions: actions,
      ),
      body: child,
      floatingActionButton: floatingActionButton,
    );
  }
}
