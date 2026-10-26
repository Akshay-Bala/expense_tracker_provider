
import 'package:expense_tracker_app/features/add_expense/models/model_expense.dart';
import 'package:expense_tracker_app/features/add_expense/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseDataTileWidget extends StatelessWidget {
  final ModelExpense expense;

  const ExpenseDataTileWidget({super.key, required this.expense});

  Future<void> _deleteExpense(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete expense?'),
        content: Text('Are you sure you want to delete "${expense.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    try {
      await context.read<ExpenseProvider>().deleteExpense(expense);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Expense deleted successfully')),
      );
    } on Exception catch (error) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete expense: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE9EBF2)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EFFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              _categoryIcon(expense.category),
              color: const Color(0xFF635BFF),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF303749),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${expense.category} · '
                  '${localizations.formatMediumDate(expense.date)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF858B9B),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${expense.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Color(0xFF172033),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Delete expense',
            onPressed: () => _deleteExpense(context),
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }

  IconData _categoryIcon(String category) => switch (category) {
    'Food & Dining' => Icons.restaurant_rounded,
    'Transportation' => Icons.directions_car_rounded,
    'Shopping' => Icons.shopping_bag_rounded,
    'Bills & Utilities' => Icons.receipt_long_rounded,
    'Healthcare' => Icons.medical_services_rounded,
    'Entertainment' => Icons.movie_rounded,
    _ => Icons.category_rounded,
  };
}