import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../services/Saeb_API.dart';
import 'search_page.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);
  Scaffold page = Scaffold(
    body: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          child: Column(
            children: const [
              Spacer(flex: 6),
              Text(
                "سيب العقار، لبيع وشراء العقار",
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff01062e)),
                textAlign: TextAlign.center,
              ),
              Text("SearchBar goes here!!"),
              Spacer(flex: 4),
            ],
          ),
          height: 400.0,
          color: Color(0xFFFEFEFE),
          width: double.infinity,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            color: Color(0xFFFEFEFE),
            child: FittedBox(
              child: Image.asset('images/artcity4.jpg'),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    return page;
  }
}


// Column(
//         children: [
//           Container(
//             height: 300.0,
//             color: Color(0xFFFEFEFE),
//             width: double.infinity,
//           ),
//           Container(
//             width: double.infinity,
//             // height: 380.0,
//             color: Color(0xFFFEFEFE),
//             child: FittedBox(
//               child: Image.asset('images/artlandscape.png'),
//               fit: BoxFit.fill,
//             ),
//           ),
//         ],
//       ),