import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../navbar/onhover.dart';
import '../across_app/colors.dart';
import '../../models/propertyarea_model.dart';
import '../../models/propertytype_model.dart';
import '../../controllers/query_controller.dart';
import 'package:get/get.dart';
import '../../pages/dealings_list.dart';
import '../../services/saeb_api.dart';
import 'helper_functions.dart';
import '../across_app/size_ratio.dart';

// ignore: must_be_immutable
class AreasBarTwo extends StatefulWidget {
  AreasBarTwo(
      {Key? key,
      required this.areas,
      required this.type,
      required this.dropDownBool,
      required this.type_index})
      : super(key: key);
  final Future<Iterable<PropertyAreaModel>> areas;
  PropertyTypeModel type;
  int type_index;
  bool dropDownBool;
  @override
  _CustomDropDownOneState createState() => _CustomDropDownOneState();
}

class _CustomDropDownOneState extends State<AreasBarTwo>
    with TickerProviderStateMixin {
  // bool isDropDownOpened = false;
  final keyBarOne = GlobalKey();
  int barLimit = 5;
  bool reachedBarLimit = false;
  double widthOfBarOne = 510;
  double barheight = 0;
  List _dealAreas = <PropertyAreaModel>[];
  List _dealAreasForDisplay = <PropertyAreaModel>[];
  List dealAreasInBar = <PropertyAreaModel>[];
  List incAreas = <PropertyAreaModel>[];
  List incAreas_ArNames = <String>[];
  List areasIdsList = [];
  String queryString = "";
  double sizeRatio = 1;
  TextEditingController textEditingController = new TextEditingController();
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: widget.areas, // function where you call your api
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff00897b)),
            ));
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              if (displayWidth(context) < 610) {
                sizeRatio = 0.71;
              } else {
                sizeRatio = 1;
                myFocusNode.requestFocus();
              }
              _dealAreas = snapshot.data!;
              incAreas = Get.find<QueryController>().areas;
              for (var i in incAreas) {
                incAreas_ArNames.add(i.nameAr.toString());
              }

              if (_dealAreasForDisplay.isEmpty &&
                  textEditingController.text == "") {
                for (var i in _dealAreas) {
                  if (incAreas_ArNames.contains(i.nameAr) == false) {
                    _dealAreasForDisplay.add(i);
                  }
                }
                dealAreasInBar = incAreas;
              }

              if (dealAreasInBar.length >= barLimit) {
                reachedBarLimit = true;
                // widget.dropDownBool = false;
                // Remove Focus
              } else {
                reachedBarLimit = false;
              }
              return RawKeyboardListener(
                autofocus: true,
                focusNode: FocusNode(),
                onKey: (event) {
                  if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                    print('DING DONG');
                  }
                },
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        // caluclateFilterBarHeight();
                        widget.dropDownBool = !widget.dropDownBool;
                        if (displayWidth(context) < 530) {
                          if (widget.dropDownBool) {
                            myFocusNode.requestFocus();
                          }
                          if (!widget.dropDownBool) {
                            myFocusNode.unfocus();
                          }
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(width: 98),
                        Column(
                          children: [
                            OnHoverButtonTwo(
                              builder: (isHovered) {
                                final colorOfBackground = isHovered
                                    ? colorGreyThreeReducedOpacity
                                    : colorGreyOne;
                                return MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Container(
                                    key: keyBarOne,
                                    width: widthOfBarOne * sizeRatio,
                                    decoration: BoxDecoration(
                                      color: widget.dropDownBool
                                          ? colorGreyZero
                                          : colorOfBackground,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        style: widget.dropDownBool
                                            ? BorderStyle.solid
                                            : BorderStyle.none,
                                        color: widget.dropDownBool
                                            ? colorB
                                            : colorOfBackground,
                                        width: 2,
                                      ),
                                    ),
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 10),
                                    child: Wrap(
                                      // spacing: 30,
                                      children: [
                                        reachedBarLimit
                                            ? const SizedBox(
                                                height: 0,
                                              )
                                            : Row(
                                                children: [
                                                  const SizedBox(width: 5),
                                                  SizedBox(
                                                    child: Text(
                                                        "اختز المناطق ...",
                                                        style: TextStyle(
                                                            color: widget
                                                                    .dropDownBool
                                                                ? colorB
                                                                : colorGreyFour,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12 *
                                                                sizeRatio)),
                                                    height: 15,
                                                  ),
                                                  const Spacer(flex: 1),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 0, 8),
                                                    child: SizedBox(
                                                      height: 20,
                                                      width:
                                                          (widthOfBarOne / 2) *
                                                              sizeRatio,
                                                      child: _SearchBar(),
                                                    ),
                                                  ),
                                                  const Spacer(flex: 4),
                                                  widget.dropDownBool
                                                      ? Icon(
                                                          Icons
                                                              .keyboard_arrow_up,
                                                          color: colorB)
                                                      : Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          color: colorGreyFour),
                                                  const SizedBox(width: 5)
                                                ],
                                              ),
                                        for (var dealArea in dealAreasInBar)
                                          _CreateAreaTag(dealArea)
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            widget.dropDownBool
                                ? reachedBarLimit
                                    ? Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 5, 20, 5),
                                        width: widthOfBarOne * sizeRatio,
                                        decoration: BoxDecoration(
                                          color: colorGreyZero,
                                          border: Border.all(
                                              color: colorB, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text("لا يمكنك اضافة المزيد",
                                            style: TextStyle(
                                                fontSize: 15 * sizeRatio,
                                                fontWeight: FontWeight.bold)),
                                      )
                                    : Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 5),
                                        height: 200,
                                        width: widthOfBarOne * sizeRatio,
                                        decoration: BoxDecoration(
                                          color: colorGreyZero,
                                          border: Border.all(
                                              color: const Color(0xff00897B),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Scrollbar(
                                          child: _dealAreasForDisplay.isNotEmpty
                                              ? ListView.builder(
                                                  // itemCount: _dealAreasForDisplay.length,

                                                  itemCount:
                                                      _dealAreasForDisplay
                                                          .length,
                                                  // ? _dealAreas.length
                                                  // : _dealAreasForDisplay.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return _ListItems(index);
                                                  },
                                                )
                                              : Center(
                                                  child: Text(
                                                  "لا توجد مناطق",
                                                  style: TextStyle(
                                                      fontSize: 20 * sizeRatio,
                                                      color: colorA,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                        ))
                                : const SizedBox(
                                    height: 0,
                                  ),
                          ],
                        ),
                        _SearchButton()
                      ],
                    )),
              );
            }
          }
        });
  }

// ------------------------------------------------------------

  _LimitReachedDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 5), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Text('Title'),
          );
        });
  }

  _CreateAreaTag(dealArea) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(1, 2, 1, 2),
        child: OnHoverButtonTwo(builder: (isHovered) {
          final colorOfText = isHovered ? colorA : colorC;
          final colorOfBackground = isHovered ? colorC : colorB;
          return GestureDetector(
            onTap: () {
              setState(() {
                if (displayWidth(context) < 530) {
                  if (widget.dropDownBool) {
                    myFocusNode.requestFocus();
                  } else {
                    myFocusNode.unfocus();
                  }
                }
                _dealAreasForDisplay.add(dealArea);
                _dealAreasForDisplay.sort((a, b) {
                  int compare =
                      a.governorate.nameAr.compareTo(b.governorate.nameAr);

                  if (compare == 0) {
                    return a.nameAr.compareTo(b.nameAr);
                  } else {
                    return compare;
                  }
                });
                dealAreasInBar.remove(dealArea);
                // _dealAreasForDisplay = [];
                // for (var i in _dealAreas) {
                //   if (i.nameEn
                //       .toLowerCase()
                //       .contains(textEditingController.text)) {
                //     _dealAreasForDisplay.add(i);
                //   }
                // }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: colorOfBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 2, color: colorB),
              ),
              height: 30,
              width: (widthOfBarOne / 5.5) * sizeRatio,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 10),
                  Text(
                      dealArea.nameAr.length >= 9
                          ? dealArea.nameAr.substring(0, 8) + "..."
                          : dealArea.nameAr,
                      style: TextStyle(
                          color: colorOfText,
                          fontWeight: FontWeight.bold,
                          fontSize: 12 * sizeRatio)),
                  const Spacer(flex: 10),
                  Icon(Icons.close, color: colorOfText),
                ],
              ),
            ),
          );
        }));
  }

  _SearchBar() {
    return TextField(
      onSubmitted: (value) {
        if (displayWidth(context) > 760) {
          navigateToPageResults();
        }
      },
      textInputAction: TextInputAction.search,
      maxLength: 20,
      cursorColor: widget.dropDownBool ? colorB : colorGreyTwoPointFive,
      decoration: const InputDecoration(
        border: InputBorder.none,
        counterText: "",
      ),
      focusNode: myFocusNode,
      controller: textEditingController,
      onChanged: (text) {
        // print('-----------------------------------');
        text = text.toLowerCase();
        // setState(() {
        //   _dealAreas = _dealAreas.where((area) {
        //     var name_en = area.nameEn.toLowerCase();
        //     return name_en.contains(text);
        //   }).toList();
        // })
        setState(() {
          if (widget.dropDownBool == false) {
            widget.dropDownBool = !widget.dropDownBool;
          }
          _dealAreasForDisplay = [];
          for (var i in _dealAreas) {
            if (i.nameEn.toLowerCase().contains(text) ||
                i.nameAr.toLowerCase().contains(text)) {
              _dealAreasForDisplay.add(i);
            }
          }
          var set1 = Set.from(_dealAreasForDisplay);
          var set2 = Set.from(dealAreasInBar);
          _dealAreasForDisplay = List.from(set1.difference(set2));
        });
        // print('-----------------------------------');
      },
    );
  }

  _SearchButton() {
    return RawMaterialButton(
      onPressed: () {
        navigateToPageResults();
      },
      elevation: 2.0,
      fillColor: colorB,
      child: Icon(
        Icons.search,
        color: colorC,
        size: 30.0 * sizeRatio,
      ),
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(),
    );
  }

  navigateToPageResults() {
    queryString = "";
    var typeIdString = widget.type.id.toString();
    queryString = queryString + "?property_type=$typeIdString";
    if (dealAreasInBar.isNotEmpty) {
      queryString = queryString + "&property_area=";
      for (var i in dealAreasInBar) {
        String toAdd = "";
        if (i == dealAreasInBar.last) {
          toAdd = i.id.toString();
        } else {
          toAdd = i.id.toString() + "+";
        }
        queryString = queryString + toAdd;
      }
    }

    Get.find<QueryController>().setType(widget.type_index);
    // Get.find<QueryController>().save_type(widget.type_index);
    // Get.find<QueryController>().save_areas(dealAreasInBar);
    // print(Get.find<QueryController>().saved_type);
    Navigator.of(context).push(_createRoute(queryString));
  }

  _ListItems(index) {
    // List dealAreas = [];
    // _dealAreasForDisplay.isEmpty
    //     ? dealAreas = _dealAreas
    //     : dealAreas = _dealAreasForDisplay;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: OnHoverButtonTwo(builder: (isHovered) {
        final colorOfButton = isHovered ? colorB : colorA;
        final colorOfBackground = isHovered ? colorGreyOne : colorGreyZero;
        return Column(
          children: [
            SizedBox(
              height: 33,
              child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      colorOfBackground,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_dealAreasForDisplay[index].governorate.nameAr,
                            style: TextStyle(
                                color: colorOfButton,
                                fontSize: 10 * sizeRatio)),
                        const Spacer(flex: 1),
                        Text(
                            _dealAreasForDisplay[index].nameAr +
                                " | " +
                                _dealAreasForDisplay[index].nameEn,
                            style: TextStyle(
                                color: colorOfButton,
                                fontSize: 14 * sizeRatio)),
                        const Spacer(flex: 1),
                        Icon(Icons.add, color: colorOfButton),
                      ],
                    ),
                  ),
                  onPressed: () => setState(() {
                        myFocusNode.requestFocus();
                        dealAreasInBar.add(_dealAreasForDisplay[index]);
                        // _dealAreas.remove(_dealAreas[index]);
                        _dealAreasForDisplay
                            .remove(_dealAreasForDisplay[index]);
                        // if (_dealAreasForDisplay.isEmpty) {
                        //   textEditingController.clear();
                        // }
                      })),
            ),
            Divider(height: 1, color: colorGreyThree),
          ],
        );
      }),
    );
  }
}

// ---------------------------------------------------------------------------------------------------

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
