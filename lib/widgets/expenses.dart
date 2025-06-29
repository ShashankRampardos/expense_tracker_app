import 'package:expense_tracker_app/widgets/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/expense_list/expenses_list.dart';
import 'package:expense_tracker_app/widgets/chart/chart.dart';

import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  @override
  void initState() {
    super.initState();
    _loadExpensesFromFile(); // async hai, but fire-and-forget hai yahan
  }

  final List<Expense> _registerededExpenses = [
    // Expense(
    //   amount: 599.99,
    //   title: 'flutter course',
    //   date: DateTime.now(),
    //   category: Category.work,
    // ),
    // Expense(
    //   amount: 199.09,
    //   title: 'cinema',
    //   date: DateTime.now(),
    //   category: Category.leisure,
    // ),
  ];

  Future<void> _saveExpensesToFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/expenses.json');
    final jsonExpenses = _registerededExpenses.map((e) => e.toJson()).toList();
    await file.writeAsString(json.encode(jsonExpenses));
  }

  Future<void> _loadExpensesFromFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/expenses.json');

    if (!file.existsSync()) return;

    final contents = await file.readAsString();
    final List<dynamic> decoded = json.decode(contents);

    setState(() {
      _registerededExpenses.clear();
      _registerededExpenses.addAll(decoded.map((e) => Expense.fromJson(e)));
    });
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registerededExpenses.add(expense);
    });
    _saveExpensesToFile();
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registerededExpenses.indexOf(expense);
    setState(() {
      _registerededExpenses.remove(expense);
    });

    _saveExpensesToFile();

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text('Item removed!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registerededExpenses.insert(expenseIndex, expense);
            });
            _saveExpensesToFile();
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return AddExpense(_addExpense);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No Expenses found. Kuch add karlo!'),
    );
    if (_registerededExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registerededExpenses,
        onDismissed: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Trac_kar_la'),
        centerTitle: true,
        elevation: 4,
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add)),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registerededExpenses),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registerededExpenses)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
