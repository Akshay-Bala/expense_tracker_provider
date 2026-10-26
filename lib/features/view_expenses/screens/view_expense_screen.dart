import 'package:expense_tracker_app/core/config/constants/app_colors.dart';
import 'package:expense_tracker_app/features/view_expenses/widgets/add_expense_button_widget.dart';
import 'package:expense_tracker_app/features/view_expenses/widgets/expense_category_filter_widget.dart';
import 'package:expense_tracker_app/features/view_expenses/widgets/expense_data_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../add_expense/provider/expense_provider.dart';

class ViewExpenseScreen extends StatefulWidget {
  const ViewExpenseScreen({super.key});

  @override
  State<ViewExpenseScreen> createState() => _ViewExpenseScreenState();
}

class _ViewExpenseScreenState extends State<ViewExpenseScreen> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text('My Expenses'),
        centerTitle: false,
        backgroundColor: const Color(0xFFF7F8FA),
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, provider, _) {
          final allExpenses = provider.expenses;

          if (allExpenses.isEmpty) {
            return const _EmptyExpensesView();
          }

          final filteredExpenses = _selectedCategory == 'All'
              ? allExpenses
              : allExpenses
                    .where((expense) => expense.category == _selectedCategory)
                    .toList();

          final filteredTotal = filteredExpenses.fold<double>(
            0,
            (total, expense) => total + expense.amount,
          );

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.horizontalPadding,
                  vertical: AppPadding.verticalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ExpenseTotalCard(
                      totalAmount: _selectedCategory == 'All'
                          ? provider.totalAmount
                          : filteredTotal,
                    ),
                    const SizedBox(height: 22),
                    Text(
                      'Filter by category',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.subTextColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ExpenseCategoryFilterWidget(
                      selectedCategory: _selectedCategory,
                      onChanged: (category) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    ),
                    const SizedBox(height: 22),
                    Text(
                      _selectedCategory == 'All'
                          ? 'Recent expenses'
                          : '$_selectedCategory expenses',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF172033),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: filteredExpenses.isEmpty
                          ? const Center(
                              child: Text(
                                'No expenses in this category.',
                                style: TextStyle(color: Color(0xFF858B9B)),
                              ),
                            )
                          : ListView.separated(
                              itemCount: filteredExpenses.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(height: 10),
                              itemBuilder: (context, index) {
                                return ExpenseDataTileWidget(
                                  expense: filteredExpenses[index],
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: const AddExpenseButtonWidget(),
    );
  }
}

class _EmptyExpensesView extends StatelessWidget {
  const _EmptyExpensesView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EFFF),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.receipt_long_rounded,
                  size: 36,
                  color: Color(0xFF635BFF),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'No expenses yet',
                style: TextStyle(color: AppColors.blackColor,fontSize: 20)
              ),
              const SizedBox(height: 10),
              Text(
                'Tap + to add your first expense. Your saved expenses will appear here.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.subTextColor,fontSize: 18)
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpenseTotalCard extends StatelessWidget {
  final double totalAmount;

  const _ExpenseTotalCard({required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF635BFF),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total expenses',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            '₹${totalAmount.toStringAsFixed(2)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
