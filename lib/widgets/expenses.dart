import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      amount: 100,
      title: "First",
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      amount: 200,
      title: "Second",
      date: DateTime.now(),
      category: Category.work,
    ),
  ];

  // when we are in a state class, the flutter framework by default assigns a
  // global state that is valid all over the statelcass
  // that is the context: context
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (ctx) {
          return SizedBox(height: 612, child: NewExpenseAdd(_addExpenseToCard));
        });
  }

  void _addExpenseToCard(Expense newExpense) {
    // final newExpense = Expense(
    //   amount: enteredAmount,
    //   category: _selectedCategory,
    //   date: _selectedDate!,
    //   title: _titleController.text,
    // );
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  void _removeExpenseFromList(Expense delExpense) {
    final deletedExpenseIndex = _registeredExpenses.indexOf(delExpense);
    setState(() {
      _registeredExpenses.remove(delExpense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Deleted expense."),
        duration: const Duration(seconds: 3),
        elevation: 0,
        action: SnackBarAction(
            label: "UNDO",
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(deletedExpenseIndex, delExpense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text("No expenses found. Start adding"),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
        listOfExpenses: _registeredExpenses,
        onRemoveExpense: _removeExpenseFromList,
      );
    }

    return Scaffold(
      // drawer: const Drawer(
      //   shadowColor: Color.fromRGBO(189, 189, 189, 1),
      //   surfaceTintColor: Colors.black,
      //   backgroundColor: Colors.black,
      //   child: Text(
      //     "This is a drawer",
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      appBar: AppBar(
        title: const Text(
          "Expense Tracker",
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(
              CupertinoIcons.add_circled_solid,
              color: Colors.black,
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: (deviceWidth < 600)
          ? Column(
              children: [
                Chart(allExpenseList: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(allExpenseList: _registeredExpenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
