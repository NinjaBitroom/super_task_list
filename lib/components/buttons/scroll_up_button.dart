import 'package:flutter/material.dart';

final class ScrollUpButton extends StatelessWidget {
  final ScrollController controller;

  const ScrollUpButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FloatingActionButton.small(
        enableFeedback: true,
        tooltip: 'Rolar para o topo',
        heroTag: 'scrollToTop',
        onPressed: () {
          controller.animateTo(
            0,
            duration: Durations.medium4,
            curve: Curves.decelerate,
          );
        },
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
