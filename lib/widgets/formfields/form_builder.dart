import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'builder_image_field.dart';
import 'builder_select_field.dart';
import 'Builder_Text_field.dart';

import 'builder_counter_field.dart';
import 'builder_date_field.dart';
import 'builder_time_field.dart';

abstract class FormBuilderField {
  final String id;
  final String label;
  final String? initValue;

  FormBuilderField({
    required this.id,
    required this.label,
    this.initValue,
  });
}

abstract class FormBuilderFieldWidget extends StatefulWidget {
  final FormBuilderField field;

  final void Function(String?) setValue;
  final String? value;

  FormBuilderFieldWidget({
    Key? key,
    required this.field,
    required this.setValue,
    required this.value,
  }) : super(key: key);
}

class FormBuilder extends StatefulWidget {
  final Future<String?> Function(Map<String, String?>) onSubmit;
  final List<FormBuilderField> fields;
  final String? title;
  final String? submitText;

  FormBuilder({
    Key? key,
    required this.fields,
    required this.onSubmit,
    this.title,
    this.submitText,
  }) : super(key: key);

  @override
  FormBuilderState createState() => FormBuilderState();
}

class FormBuilderState extends State<FormBuilder> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  Map<String, String?> data = {};
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    widget.fields.forEach((f) => data[f.id] = f.initValue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null)
              Text(
                widget.title!,
                style: Theme.of(context).textTheme.headline4,
              ),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Get.theme.errorColor),
              ),
            ...widget.fields.map((field) {
              Widget widget = Container();
              switch (field.runtimeType) {
                case BuilderTextField:
                  widget = BuilderTextFieldWidget(
                    field: field as BuilderTextField,
                    value: data[field.id],
                    setValue: (value) => setState(() => data[field.id] = value),
                  ) as Widget;
                  break;
                case BuilderSelectField:
                  widget = BuilderSelectFieldWidget(
                    field: field as BuilderSelectField,
                    value: data[field.id],
                    setValue: (value) => setState(() => data[field.id] = value),
                  );
                  break;
                case BuilderDateField:
                  widget = BuilderDateFieldWidget(
                    field: field as BuilderDateField,
                    value: data[field.id],
                    setValue: (value) => setState(() => data[field.id] = value),
                  );
                  break;
                case BuilderCounterField:
                  widget = BuilderCounterFieldWidget(
                    field: field as BuilderCounterField,
                    value: data[field.id],
                    setValue: (value) => setState(() => data[field.id] = value),
                  );
                  break;
                case BuilderTimeField:
                  widget = BuilderTimeFieldWidget(
                    field: field as BuilderTimeField,
                    value: data[field.id],
                    setValue: (value) => setState(() => data[field.id] = value),
                  );
                  break;
                case BuilderImageField:
                  widget = BuilderImageFieldWidget(
                    field: field as BuilderImageField,
                    value: data[field.id],
                    setValue: (value) => setState(() => data[field.id] = value),
                  );
                  break;
                default:
                  throw "Unimplemeted form field type: ${field.runtimeType}";
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Container(
                    constraints:
                        const BoxConstraints(maxWidth: 600, minWidth: 100),
                    child: widget),
              );
            }).toList(),
            ElevatedButton(
                onPressed: () async {
                  var e = await widget.onSubmit(this.data);

                  if (e != null) {
                    setState(() {
                      errorMessage = e;
                    });
                  }
                },
                child: Text(widget.submitText ?? "Submit"))
          ],
        ),
      ),
    );
  }
}
