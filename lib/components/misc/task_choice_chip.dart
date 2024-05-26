import 'package:flutter/material.dart';

class TaskChoiceChip extends StatelessWidget {
  final String labelText;
  final bool selected;
  final IconData? icon;
  final void Function(bool value) onSelected;

  const TaskChoiceChip(
      {super.key,
      required this.labelText,
      required this.selected,
      this.icon,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        showCheckmark: false,
        label: Text(labelText),
        selected: selected,
        avatar: icon != null ? Icon(icon) : null,
        onSelected: onSelected,
      ),
    );
  }
}
