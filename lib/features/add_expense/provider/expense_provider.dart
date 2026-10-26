import 'dart:convert';
import 'package:expense_tracker_app/features/add_expense/models/model_expense.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseProvider extends ChangeNotifier {
  static const _storageKey = 'expenses';

  final SharedPreferences _preferences;

  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  List<ModelExpense> _expenses = [];

  String _selectedCategory = 'Food & Dining';

  DateTime _selectedDate = DateTime.now();

  bool _isSaving = false;

  ExpenseProvider(this._preferences) {
    final savedExpenses = _preferences.getString(_storageKey);
    if (savedExpenses == null) return;

    final decodedExpenses = jsonDecode(savedExpenses);
    if (decodedExpenses is! List) {
      throw const FormatException('Saved expenses must be a JSON list.');
    }
    _expenses = decodedExpenses
        .map((item) => ModelExpense.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  List<ModelExpense> get expenses {
    final sortedExpenses = [..._expenses];

    sortedExpenses.sort((a, b) => b.date.compareTo(a.date));

    return List.unmodifiable(sortedExpenses);
  }
  //=> List.unmodifiable(_expenses);

  String get selectedCategory => _selectedCategory;
  DateTime get selectedDate => _selectedDate;
  bool get isSaving => _isSaving;

  double get totalAmount =>
      _expenses.fold(0, (total, expense) => total + expense.amount);

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setSaving(bool isSaving) {
    _isSaving = isSaving;
    notifyListeners();
  }

  Future<void> deleteExpense(ModelExpense expense) async {
    final updatedExpenses = [..._expenses];
    updatedExpenses.remove(expense);
    final saved = await _preferences.setString(
      _storageKey,
      jsonEncode(updatedExpenses.map((item) => item.toJson()).toList()),
    );
    if (!saved) {
      throw const ExpenseStorageException(
        'The expense could not be deleted from local storage.',
      );
    }
    _expenses = updatedExpenses;
    notifyListeners();
  }

  Future<void> addExpense(ModelExpense expense) async {
    final updatedExpenses = [..._expenses, expense];
    final saved = await _preferences.setString(
      _storageKey,
      jsonEncode(updatedExpenses.map((item) => item.toJson()).toList()),
    );
    if (!saved) {
      throw const ExpenseStorageException(
        'The expense could not be saved to local storage.',
      );
    }

    _expenses = updatedExpenses;
    notifyListeners();
    clearFields();
  }

  void clearFields() {
    titleController.clear();
    amountController.clear();
    _selectedCategory = 'Food & Dining';
    _selectedDate = DateTime.now();
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }
}

class ExpenseStorageException implements Exception {
  final String message;

  const ExpenseStorageException(this.message);

  @override
  String toString() => message;
}
