import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
    required this.selectedDate,
    required this.showDatePicker,
  });
  final DateTime? selectedDate;
  final void Function() showDatePicker;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          selectedDate == null
              ? 'Date not choosen'
              : formatter.format(selectedDate!),
        ),
        IconButton(onPressed: showDatePicker, icon: Icon(Icons.date_range)),
      ],
    );
  }
}
