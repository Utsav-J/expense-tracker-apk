import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//this.expenses is replaced by listofexpenses

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.listOfExpenses, required this.onRemoveExpense});

  final List<Expense> listOfExpenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: listOfExpenses
          .length, // item builder will be called for this number of times
      itemBuilder: (ctx, index) {
        return Dismissible(
          key: ValueKey(listOfExpenses[index]),
          background: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromARGB(255, 101, 10, 3),
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerRight,
            child: const Icon(
              CupertinoIcons.delete,
              color: Colors.white,
            ),
          ),
          child: ExpenseCard(
            listOfExpenses[index],
          ),
          onDismissed: (direction) {
            onRemoveExpense(listOfExpenses[index]);
          },
        );
      },
    );
  }
}
