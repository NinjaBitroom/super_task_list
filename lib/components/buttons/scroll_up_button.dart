import 'package:flutter/material.dart';

final class ScrollUpButton extends StatelessWidget {
  final ScrollController controller;
  final bool visible;

  const ScrollUpButton({
    super.key,
    required this.controller,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: Durations.medium1,
        child: Padding(
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
        ),
      ),
    );
  }
}
