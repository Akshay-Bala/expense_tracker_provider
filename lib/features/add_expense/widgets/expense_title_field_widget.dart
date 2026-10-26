import 'package:expense_tracker_app/core/config/constants/app_colors.dart';
import 'package:expense_tracker_app/core/widgets/expense_field_container_widget.dart';
import 'package:flutter/material.dart';

class ExpenseTitleFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;

  const ExpenseTitleFieldWidget({
    super.key,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return ExpenseFieldContainer(
      label: 'Expense Title',
      child: TextFormField(
        key: const ValueKey('expense-title-field'),
        controller: controller,
        validator: validator,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          hintText: 'e.g. Grocery shopping',
          prefixIcon: Icon(
            Icons.edit_note_rounded,
            color: Color(0xFF8C88FF),
            size: 23,
          ),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintStyle: TextStyle(color: AppColors.hintTextColor, fontSize: 14),
          contentPadding: EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
