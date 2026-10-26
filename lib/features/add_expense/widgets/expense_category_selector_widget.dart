import 'package:expense_tracker_app/core/config/constants/app_colors.dart';
import 'package:expense_tracker_app/core/widgets/common_category_option_widget.dart';
import 'package:expense_tracker_app/core/widgets/expense_field_container_widget.dart';
import 'package:flutter/material.dart';

class ExpenseCategorySelectorWidget extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;

  const ExpenseCategorySelectorWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ExpenseFieldContainer(
      label: 'Category',
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon:  Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.arrowColor,
          ),
          items: const [
            DropdownMenuItem(
              value: 'Food & Dining',
              child: CommonCategoryOptionWidget(
                icon: Icons.restaurant_rounded,
                label: 'Food & Dining',
                color: Color(0xFFFF9B54),
              ),
            ),
            DropdownMenuItem(
              value: 'Transportation',
              child: CommonCategoryOptionWidget(
                icon: Icons.directions_car_rounded,
                label: 'Transportation',
                color: Color(0xFF4C9AFF),
              ),
            ),
            DropdownMenuItem(
              value: 'Shopping',
              child: CommonCategoryOptionWidget(
                icon: Icons.shopping_bag_rounded,
                label: 'Shopping',
                color: Color(0xFFB17AFF),
              ),
            ),
            DropdownMenuItem(
              value: 'Bills & Utilities',
              child: CommonCategoryOptionWidget(
                icon: Icons.receipt_long_rounded,
                label: 'Bills & Utilities',
                color: Color(0xFF32B89A),
              ),
            ),
            DropdownMenuItem(
              value: 'Healthcare',
              child: CommonCategoryOptionWidget(
                icon: Icons.medical_services_rounded,
                label: 'Healthcare',
                color: Color(0xFFFF6B81),
              ),
            ),
            DropdownMenuItem(
              value: 'Entertainment',
              child: CommonCategoryOptionWidget(
                icon: Icons.movie_rounded,
                label: 'Entertainment',
                color: Color(0xFFEDB744),
              ),
            ),
            DropdownMenuItem(
              value: 'Other',
              child: CommonCategoryOptionWidget(
                icon: Icons.category_rounded,
                label: 'Other',
                color: Color(0xFF8B91A1),
              ),
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
