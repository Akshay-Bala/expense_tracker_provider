import 'package:expense_tracker_app/core/widgets/common_icon_button.dart';
import 'package:expense_tracker_app/core/widgets/expense_field_container_widget.dart';
import 'package:flutter/material.dart';

class ExpenseDateSelectorWidget extends StatelessWidget {
  final DateTime date;
  final ValueChanged<DateTime> onDateChanged;

  const ExpenseDateSelectorWidget({
    super.key,
    required this.date,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ExpenseFieldContainer(
      label: 'Date',
      child: Row(
        children: [
          const Icon(
            Icons.calendar_month_rounded,
            color: Color(0xFF8C88FF),
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              MaterialLocalizations.of(context).formatMediumDate(date),
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF303749),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          CommonIconButton(
            icon: Icons.edit_calendar_rounded,
            background: const Color(0xFFF0EFFF),
            foreground: const Color(0xFF635BFF),
            onTap: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (selectedDate != null) onDateChanged(selectedDate);
            },
          ),
        ],
      ),
    );
  }
}
