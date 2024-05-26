import 'package:flutter/material.dart';
import 'package:super_task_list/components/misc/task_choice_chip.dart';

class ChoiceChipList extends StatelessWidget {
  final void Function(int value) onSelected;
  final int selectedChoice;

  ChoiceChipList({
    super.key,
    required this.onSelected,
    required this.selectedChoice,
  });

  final labels = ['Todas', 'Em andamento', 'Concluídas'];
  final icons = [Icons.list, null, Icons.done_all];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(
            labels.length,
            (index) => TaskChoiceChip(
              labelText: labels[index],
              selected: selectedChoice == index,
              icon: icons[index],
              onSelected: (value) {
                onSelected(index);
              },
            ),
          )),
    );
  }
}
