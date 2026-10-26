import 'package:expense_tracker_app/core/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/add_expense/provider/expense_provider.dart';
import 'features/view_expenses/screens/view_expense_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ExpenseProvider(preferences),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF635BFF),
          surfaceTint: Colors.transparent,
        ),
        scaffoldBackgroundColor: AppColors.appBackgroundColor,
      ),
      home: const ViewExpenseScreen(),
    );
  }
}
