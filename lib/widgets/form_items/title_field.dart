import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {
  const TitleField({super.key, required this.saveTitle});
  final void Function(String) saveTitle;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: saveTitle,
      maxLength: 50,
      decoration: InputDecoration(label: Text('title')),
    );
  }
}
