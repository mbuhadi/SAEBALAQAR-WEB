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

class CustomDropDownTwo extends StatefulWidget {
  const CustomDropDownTwo({
    Key? key,
    required this.types,
    required this.areas,
  }) : super(key: key);
  final Future<Iterable<PropertyAreaModel>> areas;
  final Future<Iterable<PropertyTypeModel>> types;
  @override
  _CustomDropDownOneState createState() => _CustomDropDownOneState();
}

class _CustomDropDownOneState extends State<CustomDropDownTwo> {
  bool isDropDownOpened = false;
  List dealAreasInBar = [];

  List _dealAreas = [];
  List _dealTypes = [];
  final keyBarOne = GlobalKey();
  double widthOfBarOne = 400;
  double barheight = 0;
  int NumOfTypes = 0;

  void caluclateFilterBarHeight() =>
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          barheight = keyBarOne.currentContext!.size!.height;
        });
      });
  @override
  void initState() {
    super.initState();
    fillDealAreas();
    fillDealTypes();
  }

  // Future getTypesLength() async {
  //   var _body = await loadDealTypes();
  //   await Get.find<LookupController>().load();
  //   NumOfTypes = _body.length;
  // }

  fillDealTypes() async {
    // print("MADE CALL TO API");
    var _body = await loadDealTypes();
    for (var i = _body.length - 1; i >= 1; i--) {
      _dealTypes.add(_body[i]);
    }
  }

  loadDealTypes() async {
    var res = await http
        .get(Uri.parse('https://saebbackend.herokuapp.com/api/deals/types'));
    var body = jsonDecode(utf8.decode(res.bodyBytes));
    try {
      return body;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  fillDealAreas() async {
    var _body = await loadDealAreas();
    for (var i = _body.length - 1; i >= 1; i--) {
      _dealAreas.add(_body[i]);
    }
    // print(_dealAreas);
  }

  loadDealAreas() async {
    var res = await http
        .get(Uri.parse('https://saebbackend.herokuapp.com/api/deals/areas'));
    var body = jsonDecode(utf8.decode(res.bodyBytes));
    try {
      return body;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  List<String> labels = ["Apples", "Bananas", "Oranges", "Papayas"];
  List<bool> _selections = [];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    _selections = List.generate(1, (_) => false);
    return GestureDetector(
      onTap: () => setState(() {
        if (isDropDownOpened == true) isDropDownOpened = false;
      }),
      child: Scaffold(
        // backgroundColor: Color(0xFFffa078),
        backgroundColor: colorC,
        body: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            ToggleButtons(
              isSelected: _selections,
              onPressed: (int index) {
                setState(() {});
              },
              children: [Text("dwqklnwqkdwq")],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          caluclateFilterBarHeight();
                          isDropDownOpened = !isDropDownOpened;
                        });
                      },
                      child: OnHoverButtonTwo(
                        builder: (isHovered) {
                          final colorOfBackground =
                              isHovered ? colorGreyZero : colorGreyOne;
                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                              key: keyBarOne,
                              width: widthOfBarOne,
                              decoration: BoxDecoration(
                                color: isDropDownOpened
                                    ? colorGreyZero
                                    : colorOfBackground,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isDropDownOpened
                                      ? Color(0xff00897B)
                                      : colorGreyFour,
                                  width: 2,
                                ),
                              ),
                              padding:
                                  const EdgeInsets.fromLTRB(30, 20, 30, 20),
                              child: Wrap(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          child: Text("اختز المناطق ...",
                                              style: TextStyle(
                                                  color: isDropDownOpened
                                                      ? colorB
                                                      : colorGreyFour,
                                                  fontWeight: FontWeight.bold)),
                                          height: 20,
                                        ),
                                        // isDropDownOpened
                                        // ? SizedBox()
                                        // : Center(child: Icon(Icons.arrow_drop_down)),
                                        const Spacer(flex: 1),
                                        isDropDownOpened
                                            ? Icon(Icons.keyboard_arrow_up,
                                                color: colorB)
                                            : Icon(Icons.keyboard_arrow_down,
                                                color: colorGreyFour)
                                      ],
                                    ),
                                  ),
                                  for (var dealArea in dealAreasInBar)
                                    OnHoverButtonTwo(builder: (isHovered) {
                                      final colorOfText =
                                          isHovered ? colorA : colorC;
                                      final colorOfBackground =
                                          isHovered ? colorC : colorA;
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 2, 5, 2),
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                dealAreasInBar.remove(dealArea);
                                                _dealAreas.add(dealArea);
                                                caluclateFilterBarHeight();
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: colorOfBackground,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                    width: 2, color: (colorA)),
                                              ),
                                              height: 35,
                                              width: 150,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Spacer(flex: 10),
                                                  Text(dealArea["name_ar"],
                                                      style: TextStyle(
                                                          color: colorOfText,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14)),
                                                  Spacer(flex: 10),
                                                  Icon(Icons.close,
                                                      color: colorOfText),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    isDropDownOpened
                        ? Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            height: 200,
                            width: widthOfBarOne,
                            decoration: BoxDecoration(
                              color: colorGreyZero,
                              border: Border.all(
                                  color: Color(0xff00897B), width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Scrollbar(
                              child: ListView.builder(
                                itemCount: _dealAreas.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 0, 8.0, 0),
                                    child:
                                        OnHoverButtonTwo(builder: (isHovered) {
                                      final colorOfButton =
                                          isHovered ? colorB : colorA;
                                      final colorOfBackground = isHovered
                                          ? colorGreyOne
                                          : colorGreyZero;
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 33,
                                            child: TextButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                    colorOfBackground,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          _dealAreas[index][
                                                                  "governorate"]
                                                              ['name_ar'],
                                                          style: TextStyle(
                                                              color:
                                                                  colorOfButton,
                                                              fontSize: 10)),
                                                      const Spacer(flex: 1),
                                                      Text(
                                                          _dealAreas[index]
                                                                  ["name_ar"] +
                                                              " | " +
                                                              _dealAreas[index]
                                                                  ["name_en"],
                                                          style: TextStyle(
                                                              color:
                                                                  colorOfButton)),
                                                      const Spacer(flex: 1),
                                                      Icon(Icons.add,
                                                          color: colorOfButton),
                                                    ],
                                                  ),
                                                ),
                                                onPressed: () => setState(() {
                                                      dealAreasInBar.add(
                                                          _dealAreas[index]);
                                                      _dealAreas.remove(
                                                          _dealAreas[index]);
                                                      caluclateFilterBarHeight();
                                                    })),
                                          ),
                                          Divider(
                                              height: 1, color: colorGreyThree),
                                        ],
                                      );
                                    }),
                                  );
                                },
                              ),
                            ))
                        : const SizedBox(
                            // height: 200 + barheight,
                            // width: widthOfBarOne,
                            height: 0,
                          ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
