import 'package:flutter/material.dart';

class AmountField extends StatelessWidget {
  const AmountField({super.key, required this.saveAmount});
  final void Function(String) saveAmount;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: saveAmount,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(prefixText: '₹', label: Text('amount')),
    );
  }
}
