import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../services/Saeb_API.dart';
import 'search_page.dart';
import '../widgets/search/deal_areas_bar.dart';
import '../widgets/search/deal_types_bar.dart';
import '../models/propertyarea_model.dart';
import '../models/propertytype_model.dart';
import '../widgets/colors/colors.dart';

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
    return GestureDetector(
      onTap: () {
        setState(() {
          // caluclateFilterBarHeight();
          if (isDropDownOpened) isDropDownOpened = !isDropDownOpened;
        });
      },
      child: Scaffold(
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
                TypesBar(types: widget.types),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AreasBar(
                      dropDownBool: isDropDownOpened,
                      areas: widget.areas,
                    ),
                    RawMaterialButton(
                      onPressed: () {
                        print(TypesBar.chosenItem);
                      },
                      elevation: 2.0,
                      fillColor: colorB,
                      child: Icon(
                        Icons.search,
                        color: colorC,
                        size: 35.0,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ]),
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
