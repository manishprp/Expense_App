import 'package:expense_tracker/models/expenses.dart';
import 'package:flutter/material.dart';

class ExpenseBotomSheet extends StatefulWidget {
  const ExpenseBotomSheet(this.addExpense, {super.key});
  final Function(Expense expense) addExpense;
  @override
  State<ExpenseBotomSheet> createState() => _ExpenseBotomSheetState();
}

class _ExpenseBotomSheetState extends State<ExpenseBotomSheet> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _dateSelected;
  String _dateString = "No Date Selected";
  Category _category = Category.food;
  void _openDatePicker() async {
    final dt = DateTime.now();
    final firstDate = DateTime(dt.year - 1, dt.month, dt.day);
    var selecteddate = await showDatePicker(
        context: context, initialDate: dt, firstDate: firstDate, lastDate: dt);
    _dateSelected = selecteddate;
    setState(() {
      _dateString = formatter.format(_dateSelected!);
    });
  }

  void _submitExpenseData() {
    var amount = double.tryParse(_amountController.text);
    var isAmountValid = (amount == null || amount <= 0);

    if (_titleController.text.trim().isEmpty ||
        isAmountValid ||
        _dateSelected == null) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Oops!'),
              content: const Text('Select values corretly'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('Okay'))
              ],
            );
          });
      return;
    }
    var expense = Expense(
      amount: amount,
      category: _category,
      date: _dateSelected!,
      title: _titleController.text,
    );

    widget.addExpense(expense);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // this line of code (loc) will help up get the size of any view that overlaps the views of out screen from the bottom , mostly it is a keyboard
    // so here we will give the bottom padding to thet height of the view + out default padding
    // we must apply the scrolling facility to that column as it will take some padings and all and the screen size is limited so
    // also give the sized box on top of that so that it takes the full size of screen
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    // here we are using the layout builder in place of other way to find out screen sizxe
    // this will not work on screensizze dependency but instead it just checks the maximum available size and gives us the maxwidth min width any width
    // or height at that particular time and we can use that and absed on some conditions we can make ui responsive
    return LayoutBuilder(builder: (ctx, constrains) {
      final width = constrains.maxWidth;
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(
                      child: TextField(
                        maxLength: 50,
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                        decoration: const InputDecoration(
                          prefixText: '\$',
                          labelText: 'Amount',
                        ),
                      ),
                    ),
                  ])
                else
                  TextField(
                    maxLength: 50,
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _category,
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
                            _category = value;
                          });
                        },
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_dateString),
                            IconButton(
                              onPressed: _openDatePicker,
                              icon: const Icon(Icons.alarm_add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _amountController,
                          decoration: const InputDecoration(
                            prefixText: '\$',
                            labelText: 'Amount',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_dateString),
                            IconButton(
                              onPressed: _openDatePicker,
                              icon: const Icon(Icons.alarm_add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel')),
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Save'))
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: _category,
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
                            _category = value;
                          });
                        },
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel')),
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Save'))
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
