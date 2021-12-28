import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'form_builder.dart';

class BuilderTimeField implements FormBuilderField {
  final String id;
  final String label;
  final String initValue;
  final DateTime firstDate;
  final DateTime lastDate;

  BuilderTimeField({
    required this.id,
    required this.label,
    required this.initValue,
    required this.firstDate,
    required this.lastDate,
  });
}

class BuilderTimeFieldWidget extends FormBuilderFieldWidget {
  final BuilderTimeField field;

  BuilderTimeFieldWidget({
    Key? key,
    required this.field,
    String? value,
    required void Function(String?) setValue,
  }) : super(field: field, value: value, setValue: setValue, key: key);

  @override
  State<StatefulWidget> createState() => _DateFormField();
}

class _DateFormField extends State<BuilderTimeFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showTimePicker(
                context: context,
                initialTime: (widget.value != null && widget.value != "")
                    ? TimeOfDay(
                        hour: int.parse(widget.value!.split("-")[0]) +
                            (widget.value!.endsWith("PM") ? 12 : 0),
                        minute: int.parse(
                            widget.value!.split("-")[1].substring(0, 2)))
                    : TimeOfDay.now())
            .then((selectedDate) {
          if (selectedDate == null) return;
          widget.setValue(_formatTime(selectedDate));
        });
      },
      child: InputDecorator(
        decoration: InputDecoration(
          icon: Icon(Icons.lock_clock),
          suffixIcon: Icon(Icons.arrow_drop_down),
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
        child: Text(widget.value ?? ""),
      ),
    );
  }
}

String _formatTime(TimeOfDay d) =>
    "${d.hourOfPeriod}-${d.minute.toString().padLeft(2, "0")} ${d.period.index == 0 ? "AM" : "PM"}";
