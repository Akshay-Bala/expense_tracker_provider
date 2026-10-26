
import 'package:expense_tracker_app/core/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ExpenseFormTitleWidget extends StatelessWidget {
  const ExpenseFormTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Expense Details',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Fill in the information for your expense.',
          style: TextStyle(fontSize: 13, color: AppColors.subTextColor),
        ),
      ],
    );
  }
}