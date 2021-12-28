import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'form_builder.dart';

class BuilderDateField implements FormBuilderField {
  final String id;
  final String label;
  final String? initValue;
  final DateTime firstDate;
  final DateTime lastDate;

  BuilderDateField({
    required this.id,
    required this.label,
    this.initValue,
    DateTime? firstDate,
    required this.lastDate,
  }) : this.firstDate = firstDate ?? DateTime.now();
}

class BuilderDateFieldWidget extends FormBuilderFieldWidget {
  final BuilderDateField field;

  BuilderDateFieldWidget({
    Key? key,
    required this.field,
    required void Function(String?) setValue,
    String? value,
  }) : super(field: field, value: value, setValue: setValue, key: key);

  @override
  State<StatefulWidget> createState() => _DateFormField();
}

class _DateFormField extends State<BuilderDateFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDatePicker(
                context: context,
                firstDate: widget.field.firstDate,
                lastDate: widget.field.lastDate,
                initialDate: (widget.value != null && widget.value != "")
                    ? DateTime.parse(widget.value!)
                    : DateTime.now())
            .then((selectedDate) {
          if (selectedDate == null) return;
          widget.setValue(_formatDate(selectedDate));
        });
      },
      child: InputDecorator(
        decoration: InputDecoration(
          icon: const Icon(Icons.calendar_today),
          suffixIcon: const Icon(Icons.arrow_drop_down),
          isDense: true,
          border: const UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.grey)),
          enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(width: 2, color: Get.textTheme.headline6!.color!)),
          errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.red)),
          disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.grey[300]!)),
          labelStyle: Theme.of(context).textTheme.headline6,
          labelText: widget.field.label,
        ),
        isEmpty: (widget.value ?? "") == "",
        child: Text(widget.value ?? ""),
      ),
    );
  }
}

String _formatDate(DateTime d) => "${d.year}-${d.month}-${d.day}";
