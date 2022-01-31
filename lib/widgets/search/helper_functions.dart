import 'package:flutter/material.dart';
import '../across_app/colors.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  // final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    // required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return TextField(
      controller: controller,
      cursorColor: colorB,
      decoration: InputDecoration(
        suffixIcon: widget.text.isNotEmpty
            ? GestureDetector(
                child: Icon(Icons.close, color: style.color),
                onTap: () {
                  controller.clear();
                  widget.onChanged('');
                  // FocusScope.of(context).requestFocus(FocusNode());
                },
              )
            : null,
        hintStyle: style,
        border: InputBorder.none,
      ),
      style: style,
      onChanged: widget.onChanged,
    );
  }
}
