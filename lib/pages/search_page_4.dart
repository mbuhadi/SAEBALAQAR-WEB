import 'package:flutter/material.dart';
import '../widgets/navbar/onhover.dart';
import '../widgets/colors/colors.dart';
import 'package:get/get.dart';
import '../controllers/lookup_controller.dart';
import '../models/propertyarea_model.dart';
import '../models/propertytype_model.dart';
import '../services/saeb_api.dart';
import '../services/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TestDropDown extends StatefulWidget {
  const TestDropDown({
    Key? key,
    required this.source,
  }) : super(key: key);
  final Future<Iterable<PropertyTypeModel>> source;
  @override
  _TestDropDownState createState() => _TestDropDownState();
}

class _TestDropDownState extends State<TestDropDown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.source);
    return FutureBuilder<dynamic>(
      future: widget.source, // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Please wait its loading...'));
        } else {
          if (snapshot.hasError) {
            print(snapshot.data!);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else
            return Center(
                child: ListView(
                    children: snapshot.data!
                        .map<Widget>((type) => Text(type.nameAr))
                        .toList())); // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }
}
