import 'package:flutter/material.dart';

class CollectionNameForm extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool readonly;
  final Function(String) onNameChanged;
  final GlobalKey<FormState> formKey; // Add this line

  CollectionNameForm({
    required this.controller,
    required this.focusNode,
    required this.readonly,
    required this.onNameChanged,
    required this.formKey, // And this line
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          hintText: "Nazwa kolekcji",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Nazwa kolekcji nie może być pusta';
          }
          return null;
        },
        onChanged: onNameChanged,
        readOnly: readonly,
      ),
    );
  }
}