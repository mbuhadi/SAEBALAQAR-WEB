import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/formfields/form_builder.dart';

class BuilderCounterField implements FormBuilderField {
  final String id;
  final String label;
  final String? initValue;

  final int min;
  final int max;

  final int initCount;

  BuilderCounterField({
    required this.id,
    required this.label,
    this.min: 0,
    required this.max,
    int? initCount,
  })  : this.initCount = initCount ?? min,
        this.initValue = initCount?.toString();
}

class BuilderCounterFieldWidget extends FormBuilderFieldWidget {
  final BuilderCounterField field;

  BuilderCounterFieldWidget({
    Key? key,
    required this.field,
    required void Function(String?) setValue,
    String? value,
  }) : super(field: field, value: value, setValue: setValue, key: key);

  @override
  State<StatefulWidget> createState() => _DateFormField();
}

class _DateFormField extends State<BuilderCounterFieldWidget> {
  int get number {
    return int.tryParse(widget.value ?? widget.field.min.toString()) ??
        widget.field.min;
  }

  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.field.initValue ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            onChanged: (v) {
              int number = int.tryParse(v) ?? widget.field.min;

              if (v == "") {
                updateValue(null);
                controller.text = "";
                return;
              }
              if (number < widget.field.min) {
                updateValue(widget.field.min);
                controller.text = widget.field.min.toString();
                return;
              }
              if (number > widget.field.max) {
                updateValue(widget.field.max);
                controller.text = widget.field.max.toString();
                return;
              }

              updateValue(number);
            },
            validator: (s) =>
                s == null || RegExp(r"^\d+$").allMatches(s).isEmpty
                    ? "Only numbers allowed"
                    : null,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              isDense: true,
              border: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.grey)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 2, color: Get.textTheme!.headline6!.color!)),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.red)),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.grey[300]!)),
              labelStyle: Theme.of(context).textTheme.headline6,
              labelText: widget.field.label,
            ),
          ),
        ),
        InkWell(
          child: Icon(
            Icons.remove,
            size: 24,
            color: number <= widget.field.min
                ? Theme.of(context).disabledColor
                : Theme.of(context).primaryColor,
          ),
          onTap: number <= widget.field.min
              ? null
              : () => updateValue(number - 1, true),
        ),
        SizedBox(
          width: 5,
        ),
        InkWell(
          child: Icon(
            Icons.add,
            size: 24,
            color: number >= widget.field.max
                ? Theme.of(context).disabledColor
                : Theme.of(context).primaryColor,
          ),
          onTap: number >= widget.field.max
              ? null
              : () => updateValue(number + 1, true),
        ),
      ],
    );
  }

  void updateValue(int? count, [bool fromButton = false]) {
    String? nextValue;

    if (fromButton) FocusScope.of(context).requestFocus(new FocusNode());

    if (fromButton && widget.value == null) {
      nextValue = widget.field.min.toString();
    } else {
      nextValue = widget.value == null
          ? widget.field.min.toString()
          : count?.toString();
    }

    setState(() {
      widget.setValue(nextValue);
    });

    if (fromButton) controller.text = nextValue ?? "";
  }
}
