import 'package:flutter/material.dart';

class ExpenseCategoryFilterWidget extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onChanged;

  const ExpenseCategoryFilterWidget({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
  });

  static const categories = [
    'All',
    'Food & Dining',
    'Transportation',
    'Shopping',
    'Bills & Utilities',
    'Healthcare',
    'Entertainment',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final selected = category == selectedCategory;

          return ChoiceChip(
            label: Text(category),
            selected: selected,
            onSelected: (_) => onChanged(category),
            selectedColor: const Color(0xFF635BFF),
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: selected ? Colors.white : const Color(0xFF303749),
              fontWeight: FontWeight.w500,
            ),
            side: BorderSide(
              color: selected
                  ? const Color(0xFF635BFF)
                  : const Color(0xFFE9EBF2),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ),
    );
  }
}
