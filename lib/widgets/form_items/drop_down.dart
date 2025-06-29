import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';

class DropDown extends StatelessWidget {
  final Category selectedCategory;
  final void Function(Category) onSelectCategory;

  const DropDown({
    super.key,
    required this.selectedCategory,
    required this.onSelectCategory,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Category>(
      value: selectedCategory,
      items: Category.values
          .map(
            (category) => DropdownMenuItem<Category>(
              value: category,
              child: Text(category.name.toUpperCase()),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value != null) {
          onSelectCategory(value);
        }
      },
    );
  }
}
