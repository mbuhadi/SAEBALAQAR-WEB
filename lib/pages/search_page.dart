import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FilterBarOne extends StatefulWidget {
  FilterBarOne({Key? key}) : super(key: key);
  @override
  _FilterBarOneState createState() => _FilterBarOneState();
}

class _FilterBarOneState extends State<FilterBarOne> {
  List itemsInBarOne = [];
  var items = ['A', 'B', 'C', 'D'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            DropdownButton<String>(
              hint: Text("TestTest"),
              icon: const Icon(Icons.arrow_downward),
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (item) => setState(() {
                itemsInBarOne.add(item);
                items.remove(item);
              }),
            ),
            for (var i in itemsInBarOne)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(i),
                  TextButton(
                      onPressed: () => setState(() {
                            itemsInBarOne.remove(i);
                            items.add(i);
                          }),
                      child: const Text("REMOVE",
                          style: TextStyle(color: Colors.black)))
                ],
              )
          ],
        ),
      ),
    );
  }
}
