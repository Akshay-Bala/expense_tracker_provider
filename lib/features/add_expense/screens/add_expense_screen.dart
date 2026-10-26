import 'package:expense_tracker_app/core/config/constants/app_colors.dart';
import 'package:expense_tracker_app/features/add_expense/widgets/expense_amount_widget.dart';
import 'package:expense_tracker_app/features/add_expense/widgets/expense_category_selector_widget.dart';
import 'package:expense_tracker_app/features/add_expense/widgets/expense_date_selector_widget.dart';
import 'package:expense_tracker_app/features/add_expense/widgets/expense_form_title_widget.dart';
import 'package:expense_tracker_app/features/add_expense/widgets/expense_title_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/model_expense.dart';
import '../provider/expense_provider.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  Future<void> _saveExpense(
    BuildContext context,
    ExpenseProvider provider,
  ) async {
    if (!provider.formKey.currentState!.validate()) return;
    provider.setSaving(true);
    try {
      await provider.addExpense(
        ModelExpense(
          title: provider.titleController.text.trim(),
          amount: double.parse(provider.amountController.text.trim()),
          category: provider.selectedCategory,
          date: provider.selectedDate,
        ),
      );
      if (!context.mounted) return;
      Navigator.pop(context);
    } on Exception catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not save expense: $error')));
    } finally {
      provider.setSaving(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.horizontalPadding,
            vertical: AppPadding.verticalPadding,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Form(
                key: provider.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const ExpenseFormTitleWidget(),
                    const SizedBox(height: 20),
                    ExpenseTitleFieldWidget(
                      controller: provider.titleController,
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'Enter an expense title'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    ExpenseAmountWidget(
                      controller: provider.amountController,
                      validator: (value) {
                        final amount = double.tryParse(value?.trim() ?? '');
                        if (amount == null || amount <= 0) {
                          return 'Enter an amount greater than zero';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ExpenseCategorySelectorWidget(
                      value: provider.selectedCategory,
                      onChanged: (value) {
                        if (value != null) provider.selectCategory(value);
                      },
                    ),
                    const SizedBox(height: 20),
                    ExpenseDateSelectorWidget(
                      date: provider.selectedDate,
                      onDateChanged: provider.selectDate,
                    ),
                    const SizedBox(height: 30),
                    ExpenseSaveButton(
                      isSaving: provider.isSaving,
                      onPressed: () => _saveExpense(context, provider),
                    ),
                    const SizedBox(height: 20),
                    const ExpenseFooter(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExpenseSaveButton extends StatelessWidget {
  final bool isSaving;
  final VoidCallback onPressed;

  const ExpenseSaveButton({
    super.key,
    required this.isSaving,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isSaving ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF635BFF),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSaving)
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            else
              const Icon(Icons.add_rounded, size: 22),
            const SizedBox(width: 8),
            Text(
              isSaving ? 'Saving...' : 'Save Expense',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseFooter extends StatelessWidget {
  const ExpenseFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(Icons.lock_outline_rounded, size: 14, color: Color(0xFF9BA1B0)),
        SizedBox(width: 6),
        Text(
          'Your expense details are ready to be saved',
          style: TextStyle(fontSize: 11, color: Color(0xFF9BA1B0)),
        ),
      ],
    );
  }
}
