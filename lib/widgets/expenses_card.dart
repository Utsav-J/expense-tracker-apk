import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(context) {
    return Card(
      surfaceTintColor: Colors.blueGrey,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            expense.title.toUpperCase(),
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontFamily: "GameOver",
                fontSize: 50,
                color: Colors.black,
                shadows: null),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                "Rs ${expense.amount.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontFamily: "LCD",
                  fontSize: 17,
                  // fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(categoryIcons[expense.category]),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    expense.formattedDate,
                    style: const TextStyle(
                      fontFamily: "GameOver",
                      fontSize: 50,
                    ),
                  )
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}
