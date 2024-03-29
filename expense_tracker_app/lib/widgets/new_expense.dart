import 'dart:io';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(
      {super.key, required this.onAddExpense}); //receiving function as props

  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
            title: const Text('Invalid input'),
            content: const Text(
                'Please make sure a valid title, date, amount and category was entered.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx); //Return to the first route
                },
                child: const Text('Okay'),
              )
            ]),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            title: const Text('Invalid input'),
            content: const Text(
                'Please make sure a valid title, date, amount and category was entered.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx); //Return to the first route
                },
                child: const Text('Okay'),
              )
            ]),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

// middleware for Alert dialog
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }

// passing data to parent.
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category:
            _selectedCategory)); // creating new class using 'Expense' class

    Navigator.pop(context);
  }

  @override
  // cleanUp function for memory
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

// creating Widget
  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    // LayoutBuilder builds a widget tree that can depend on the parent widget's size.
    return LayoutBuilder(builder: (ctx, constraints) {
      final maxWidth = constraints.maxWidth;

      return Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
        child: Column(
          children: [
            if (maxWidth >= 600)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _titleController, // method2. onChangeHandler
                      maxLength: 50,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        label: Text('Title'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _amountController, // onChangeHandler
                      maxLength: 20,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$ ', // $25
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                ],
              )
            else
              TextField(
                controller: _titleController, // method2. onChangeHandler
                maxLength: 50,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController, // onChangeHandler
                    maxLength: 20,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: '\$ ', // $25
                      label: Text('Amount'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(_selectedDate == null
                          ? 'Selected Date'
                          : formatter.format(_selectedDate!)),
                      IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }

                      setState(() {
                        _selectedCategory = value;
                      });
                    }),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context); //Return to the first route
                    },
                    child: const Text('Cancel')),
                ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: const Text('Save Expense'))
              ],
            ),
          ],
        ),
      );
    });
  }
}
