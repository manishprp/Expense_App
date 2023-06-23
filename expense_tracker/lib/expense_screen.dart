import 'package:expense_tracker/expense_adapter.dart';
import 'package:expense_tracker/models/expenses.dart';
import 'package:flutter/material.dart';
import 'chart.dart';
import 'expense_bottomsheet.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final List<Expense> _registeredExpenses = [
    Expense(
        amount: 19.19,
        title: "Flutter Course",
        date: DateTime.now(),
        category: Category.work),
    Expense(
        amount: 19.19,
        title: "Flutter Course",
        date: DateTime.now(),
        category: Category.work)
  ];
  void _openAddExpenseBottomSheet() {
    showModalBottomSheet(
        useSafeArea:
            true, // this keeps out ui from the cameras and other screen hindrances
        isScrollControlled: true,
        context: context,
        builder: (ctx) => ExpenseBotomSheet(_addExpenseNew));
  }

  void _addExpenseNew(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpenseNew(Expense expense) {
    var index = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Deleted Item ',
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: ' Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget? mainScreen;
    if (_registeredExpenses.isNotEmpty) {
      mainScreen = ExpenseItem(
        expemnseListIn: _registeredExpenses,
        removeExpense: _removeExpenseNew,
      );
    } else {
      mainScreen = const Center(child: Text('No data available'));
    }

    return Scaffold(
        appBar: AppBar(title: const Text('Expense Tracker'), actions: [
          IconButton(
              onPressed: _openAddExpenseBottomSheet,
              icon: const Icon(Icons.add))
        ]),
        // here we have this column so when the screen rotates to landscape the width inchreases and height decreases and therefore we have to show the ui side by side elements
        // means a row instead of column, therefore when rotated we the code runs again or build method, so if we check the width at thaty time and then display column or row
        // based on the condition then this way the ui will be responsive..
        body: width <= 600
            ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(
                    child: mainScreen,
                  )
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(
                    child: mainScreen,
                  )
                ],
              ));
  }
}
