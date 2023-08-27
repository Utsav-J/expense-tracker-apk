// import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

// import 'package:intl/intl.dart';
// we could make a new dateFormatter but we instead used the above expense dart file to import the dateformatter that we made previously

class NewExpenseAdd extends StatefulWidget {
  const NewExpenseAdd(this.onAddExpense, {super.key});
  final void Function(Expense newExpense) onAddExpense;
  @override
  State<NewExpenseAdd> createState() {
    return _NewExpenseAddState();
  }
}

class _NewExpenseAddState extends State<NewExpenseAdd> {
  // an object that is made for controlling user input text
  // has to be destroyed after being used so that it doesnt cause memory leak
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    // showdate picker will return a future datetime value,
    // we can either use .then method and pass in a function to operate with thefuture value
    // or we can use the async-await method
    // ONLY WORKS FOR FUTURE VALUES
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    // THE LINE AT THIS POSITION WILL ONLY WORK ONCE THE AWAITED FUNCTION HAS BEEN COMPLETED
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = (enteredAmount == null || enteredAmount <= 0);
    final dateIsInvalid = (_selectedDate == null);
    final titleIsInvalid = _titleController.text.trim().isEmpty;
    // note that we didnt check if category was null, this is because it has a default value already

    if (amountIsInvalid || titleIsInvalid || dateIsInvalid) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Invalid Input!"),
            content:
                const Text("Make sure the amount, date and category are valid"),
            actions: [
              TextButton.icon(
                icon: const Icon(
                  CupertinoIcons.checkmark_alt_circle_fill,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(ctx);
                },
                label: const Text(
                  "OK",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          );
        },
      );
      return; // making sure this is the end of the function
    }
    // final newExpense =;
    widget.onAddExpense(Expense(
      amount: enteredAmount,
      category: _selectedCategory,
      date: _selectedDate!,
      title: _titleController.text,
    ));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final deviceWidth = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, keyboardSpace + 20),
            child: Column(
              children: [
                if (deviceWidth >= 60)
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text(
                              "TITLE",
                              style: TextStyle(
                                  fontFamily: "GameOver",
                                  fontSize: 40,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: "Rs. ",
                            label: Text("AMOUNT",
                                style: TextStyle(
                                    fontFamily: "GameOver",
                                    fontSize: 40,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      )
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text(
                        "TITLE",
                        style: TextStyle(
                            fontFamily: "GameOver",
                            fontSize: 40,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                if (deviceWidth >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values.map((categoryData) {
                          return DropdownMenuItem(
                            value: categoryData,
                            child: Text(categoryData.name.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (categoryData) {
                          if (categoryData == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = categoryData;
                          });
                        },
                      ),
                      const Spacer(),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              (_selectedDate == null)
                                  ? "Not Selected"
                                  : dateFormatter.format(
                                      _selectedDate!), //->! means that it WONT be null // ? means that it CAN BE null
                            ),
                            IconButton(
                              onPressed: presentDatePicker,
                              icon: const Icon(CupertinoIcons.calendar),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: "Rs. ",
                            label: Text("AMOUNT",
                                style: TextStyle(
                                    fontFamily: "GameOver",
                                    fontSize: 40,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              (_selectedDate == null)
                                  ? "Not Selected"
                                  : dateFormatter.format(
                                      _selectedDate!), //->! means that it WONT be null // ? means that it CAN BE null
                            ),
                            IconButton(
                              onPressed: presentDatePicker,
                              icon: const Icon(CupertinoIcons.calendar),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                if (deviceWidth >= 600)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: _submitExpenseData,
                        icon: const Icon(CupertinoIcons.checkmark_circle_fill),
                        iconSize: 30,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(
                              context); // will pop out of the current overlay
                        },
                        icon: const Icon(CupertinoIcons.xmark_circle_fill),
                        iconSize: 30,
                      )
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values.map((categoryData) {
                          return DropdownMenuItem(
                            value: categoryData,
                            child: Text(categoryData.name.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (categoryData) {
                          if (categoryData == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = categoryData;
                          });
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: _submitExpenseData,
                        icon: const Icon(CupertinoIcons.checkmark_circle_fill),
                        iconSize: 30,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(
                              context); // will pop out of the current overlay
                        },
                        icon: const Icon(CupertinoIcons.xmark_circle_fill),
                        iconSize: 30,
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
