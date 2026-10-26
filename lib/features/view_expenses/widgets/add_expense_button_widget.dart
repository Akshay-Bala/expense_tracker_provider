import 'package:expense_tracker_app/core/config/constants/app_colors.dart';
import 'package:expense_tracker_app/features/add_expense/screens/add_expense_screen.dart';
import 'package:flutter/material.dart';

class AddExpenseButtonWidget extends StatelessWidget {
  const AddExpenseButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
        );
      },
      backgroundColor: AppColors.floatingButtonColor,
      foregroundColor: AppColors.whiteColor,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: const Icon(Icons.add_rounded, size: 30),
    );
  }
}
