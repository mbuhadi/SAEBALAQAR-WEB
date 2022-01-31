import 'package:daymanager3/controllers/query_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../services/Saeb_API.dart';
import '../widgets/search/deal_areas_bar.dart';
import '../widgets/search/deal_types_bar.dart';
import '../models/propertyarea_model.dart';
import '../models/propertytype_model.dart';
import '../widgets/across_app/colors.dart';
import '../../pages/dealings_list.dart';

class LandingPage extends StatefulWidget {
  LandingPage({
    Key? key,
    required this.types,
    required this.areas,
  }) : super(key: key);
  final Future<Iterable<PropertyAreaModel>> areas;
  final Future<Iterable<PropertyTypeModel>> types;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  bool isDropDownOpened = false;
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).viewInsets.bottom == 0);
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
          print("BING BONG");
        }
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          print("BING BONG");
        }
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            // caluclateFilterBarHeight();
            if (isDropDownOpened) isDropDownOpened = !isDropDownOpened;
          });
        },
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          resizeToAvoidBottomInset: false,
          backgroundColor: colorC,
          body: Stack(children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "سيْب العقار، لبيع وشراء العقار",
                        style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff01062e)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 200,
                ),
                SizedBox(
                  height: 240,
                  width: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Image.asset('images/artcity4.jpg'),
                  ),
                ),
              ],
            ),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 260,
                  ),
                  TypesBarTwo(
                    types: widget.types,
                    dropDownBool: isDropDownOpened,
                    areas: widget.areas,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// GestureDetector(
// onTap: () {
//   setState(() {
//     caluclateFilterBarHeight();
//     isDropDownOpened = !isDropDownOpened;
//   });
// },)
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

// Column(
//               children: const [
//                 // Spacer(flex: 2),
//                 Text(
//                   "سيب العقار، لبيع وشراء العقار",
//                   style: TextStyle(
//                       fontSize: 60,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xff01062e)),
//                   textAlign: TextAlign.center,
//                 ),
//                 // Spacer(flex: 1),
//               ],
//             ),
//             height: 400.0,
//             color: Color(0xFFFEFEFE),
//             width: double.infinity,
//           ),
Route _createRoute(query) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => DealingsList(
      source: SaebAPI.deals(query),
      editable: false,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
