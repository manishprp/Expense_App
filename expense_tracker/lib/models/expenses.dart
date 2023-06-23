import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

enum Category { food, travel, leisure, work }

var formatter = DateFormat.yMd();
const uid = Uuid();

const Map<Category, IconData> categoryIcons = {
  Category.work: Icons.work,
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff
};

class Expense {
  Expense(
      {required this.amount,
      required this.title,
      required this.date,
      required this.category})
      : id = uid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get FormatedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpense, this.category)
      : expenses = allExpense
            .where((element) => element.category == category)
            .toList();
  double get totalexpense {
    double sum = 0;
    for (var exp in expenses) {
      sum += exp.amount;
    }
    return sum;
  }

  final Category category;
  final List<Expense> expenses;
}
