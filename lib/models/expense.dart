// import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dateFormatter = DateFormat.MMMd();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: (Icons.fastfood_sharp),
  Category.travel: (CupertinoIcons.airplane),
  Category.leisure: (CupertinoIcons.gamecontroller_alt_fill),
  Category.work: (CupertinoIcons.mail_solid),
};

class Expense {
  Expense(
      {required this.amount,
      required this.title,
      required this.date,
      required this.category})
      : uniqueID = uuid.v4();

  final double amount;
  final String title;
  final String uniqueID; // will be built using uuid library
  final DateTime date;
  final Category category;

  //example of getter funciton
  String get formattedDate {
    return dateFormatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.categoryExpenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : categoryExpenses = allExpenses
            .where((expense) => (expense.category == category))
            .toList(); // will filter the expenses that belong to that catergory

  final Category category;
  final List<Expense> categoryExpenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in categoryExpenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
