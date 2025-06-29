import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/form_items/amount_field.dart';
import 'package:expense_tracker_app/widgets/form_items/date_picker.dart';
import 'package:expense_tracker_app/widgets/form_items/drop_down.dart';
import 'package:expense_tracker_app/widgets/form_items/title_field.dart';
import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  const AddExpense(this.addExpense, {super.key});
  final void Function(Expense)
  addExpense; // check if it is ok to make this final
  @override
  State<StatefulWidget> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  String? _selectedTitle;
  DateTime? _selectedDate;
  String? _selectedAmount;
  Category _selectedCategory = Category.leisure;

  void _saveTitle(String title) {
    _selectedTitle = title;
  }

  void _saveAmount(String amount) {
    _selectedAmount = amount;
  }

  void _showDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _saveExpense() {
    //validating all input fields
    if (_selectedTitle == null ||
        _selectedTitle!.trim().isEmpty ||
        _selectedAmount == null ||
        _selectedAmount!.trim().isEmpty ||
        double.tryParse(_selectedAmount!) == null ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid input'),
          content: Text('Please enter valid input!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Okey'),
            ),
          ],
        ),
      );
      return;
    }
    //all input fields are validated and are correct
    Expense newExpense = Expense(
      amount: double.parse(_selectedAmount!),
      title: _selectedTitle!,
      date: _selectedDate!,
      category: _selectedCategory,
    );
    widget.addExpense(newExpense);
    Navigator.pop(context);
  }

  //Dropdown button function
  void onSelectCategory(Category newCategory) {
    setState(() {
      _selectedCategory = newCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + keyboardSpace),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: TitleField(saveTitle: _saveTitle)),
                        Spacer(),
                        Expanded(child: AmountField(saveAmount: _saveAmount)),
                      ],
                    )
                  else
                    TitleField(saveTitle: _saveTitle),

                  Row(
                    children: [
                      if (width >= 600)
                        DropDown(
                          selectedCategory: _selectedCategory,
                          onSelectCategory: onSelectCategory,
                        )
                      else
                        Expanded(child: AmountField(saveAmount: _saveAmount)),

                      const SizedBox(width: 16),
                      Expanded(
                        child: DatePicker(
                          selectedDate: _selectedDate,
                          showDatePicker: _showDatePicker,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      if (width < 600)
                        DropDown(
                          selectedCategory: _selectedCategory,
                          onSelectCategory: onSelectCategory,
                        ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _saveExpense,
                        child: Text('Save Expense'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
