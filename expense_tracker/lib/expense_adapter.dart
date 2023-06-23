import 'package:expense_tracker/expense_row_item.dart';
import 'package:expense_tracker/models/expenses.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(
      {super.key, required this.expemnseListIn, required this.removeExpense});
  final List<Expense> expemnseListIn;
  final void Function(Expense expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expemnseListIn.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error,
            ),
            onDismissed: (direction) {
              removeExpense(expemnseListIn[index]);
            },
            key: ValueKey(expemnseListIn[index]),
            child: ExpenseRowItem(expemnseListIn[index]),
          );
        });
  }
}
