import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'form_builder.dart';

class BuilderTextField implements FormBuilderField {
  final String id;
  final String label;
  final String? initValue;

  final List<String> suggestions;

  BuilderTextField({
    required this.id,
    required this.label,
    this.initValue,
    this.suggestions = const [],
  });
}

class BuilderTextFieldWidget extends FormBuilderFieldWidget {
  final BuilderTextField field;

  BuilderTextFieldWidget({
    Key? key,
    required this.field,
    String? value,
    required void Function(String?) setValue,
  }) : super(field: field, value: value, setValue: setValue, key: key);

  @override
  State<StatefulWidget> createState() => _TextFormField();
}

class _TextFormField extends State<BuilderTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.field.initValue,
      decoration: InputDecoration(
        isDense: true,
        border: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.grey)),
        enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(width: 2, color: Get.textTheme!.headline6!.color!)),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.red)),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.grey[300]!)),
        labelText: widget.field.label,
        labelStyle: Theme.of(context).textTheme.headline6,
      ),
      onChanged: (value) => widget.setValue(value),
    );
  }
}
