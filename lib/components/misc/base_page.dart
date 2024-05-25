import 'package:flutter/material.dart';
import 'package:super_task_list/utils/app_theme.dart';

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
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading ?? true,
        leading: leading,
        title: Text(title),
        actions: actions,
        centerTitle: true,
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.9),
        systemOverlayStyle: AppTheme.createSystemUiOverlayStyle(context),
      ),
      body: child,
      floatingActionButton: floatingActionButton,
    );
  }
}
