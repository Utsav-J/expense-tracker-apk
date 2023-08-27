import 'dart:math';

import 'package:flutter/material.dart';

import 'chart_bar.dart';
import 'package:expense_tracker/models/expense.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.allExpenseList});
  final List<Expense> allExpenseList;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(allExpenseList, Category.food),
      ExpenseBucket.forCategory(allExpenseList, Category.work),
      ExpenseBucket.forCategory(allExpenseList, Category.leisure),
      ExpenseBucket.forCategory(allExpenseList, Category.travel),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;
    for (final bucket in buckets) {
      maxTotalExpense = max(bucket.totalExpenses, maxTotalExpense);
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill: bucket.totalExpenses == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category],
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
