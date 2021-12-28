import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'form_builder.dart';

class SelectItem {
  final String label;
  final String value;
  SelectItem({
    required this.value,
    String? label,
  }) : this.label = label ?? value;
}

class BuilderSelectField implements FormBuilderField {
  final String id;
  final String label;
  final String? initValue;

  List<SelectItem> items;

  BuilderSelectField({
    required this.id,
    required this.label,
    required this.items,
    this.initValue,
  });
}

class BuilderSelectFieldWidget extends FormBuilderFieldWidget {
  final BuilderSelectField field;

  BuilderSelectFieldWidget({
    Key? key,
    required this.field,
    required void Function(String?) setValue,
    String? value,
  }) : super(field: field, value: value, setValue: setValue, key: key);

  @override
  State<StatefulWidget> createState() => _SelectFormField();
}

class _SelectFormField extends State<BuilderSelectFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return InputDecorator(
        decoration: InputDecoration(
          isDense: true,
          border: UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.grey)),
          enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(width: 2, color: Get.textTheme.headline6!.color!)),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.red)),
          disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.grey[300]!)),
          labelStyle: Theme.of(context).textTheme.headline6,
          labelText: widget.field.label,
        ),
        isEmpty: (widget.value ?? "") == "",
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            isDense: true,
            value: widget.value,
            iconEnabledColor: Get.textTheme.headline6!.color!,
            onChanged: (v) => widget.setValue(v),
            items: this
                .widget
                .field
                .items
                .map((i) => DropdownMenuItem(
                      child: Text(i.label),
                      value: i.value,
                      onTap: () =>
                          FocusScope.of(context).requestFocus(new FocusNode()),
                    ))
                .toList(),
          ),
        ));
  }
}
