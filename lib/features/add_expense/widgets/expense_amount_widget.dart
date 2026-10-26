import 'package:expense_tracker_app/core/config/constants/app_colors.dart';
import 'package:expense_tracker_app/core/widgets/expense_field_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExpenseAmountWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;

  const ExpenseAmountWidget({
    super.key,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return ExpenseFieldContainer(
      label: 'Amount',
      child: TextFormField(
        key: const ValueKey('expense-amount-field'),
        controller: controller,
        validator: validator,
        textInputAction: TextInputAction.next,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        decoration: InputDecoration(
          hintText: 'e.g. 24.50',
          prefixIcon: Icon(
            Icons.currency_rupee_sharp,
            color: Color(0xFF8C88FF),
            size: 23,
          ),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintStyle: TextStyle(color: AppColors.hintTextColor, fontSize: 14),
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}
