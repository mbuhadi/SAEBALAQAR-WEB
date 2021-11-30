import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'form_builder.dart';

class BuilderImageField implements FormBuilderField {
  final String id;
  final String label;
  final String? initValue;

  BuilderImageField({
    required this.id,
    required this.label,
    this.initValue,
  });
}

class BuilderImageFieldWidget extends FormBuilderFieldWidget {
  final BuilderImageField field;

  final double size;

  BuilderImageFieldWidget({
    Key? key,
    required this.field,
    String? value,
    this.size = 300,
    required void Function(String?) setValue,
  }) : super(field: field, value: value, setValue: setValue, key: key);

  @override
  State<StatefulWidget> createState() => _BuilderImageField();
}

class _BuilderImageField extends State<BuilderImageFieldWidget> {
  Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.field.label),
        if (bytes == null && widget.field.initValue != null)
          Image.network(
            widget.field.initValue!,
            width: widget.size,
          ),
        if (bytes != null) Image.memory(bytes!, width: widget.size),
        IconButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.image, withData: true, allowMultiple: false);
              if (result == null) {
                return;
              }

              var file = result.files.first;

              setState(() {
                String data =
                    "data:${file.extension};base64,${base64.encode(file.bytes!)}";
                widget.setValue(data);
                this.bytes = file.bytes;
              });
            },
            icon: Icon(Icons.file_upload))
      ],
    );
  }
}
