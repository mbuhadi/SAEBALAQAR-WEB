import 'package:flutter/material.dart';
import '../navbar/onhover.dart';
import '../colors/colors.dart';
import '../../models/propertyarea_model.dart';

// ignore: must_be_immutable
class AreasBar extends StatefulWidget {
  AreasBar({
    Key? key,
    required this.areas,
    required this.dropDownBool,
  }) : super(key: key);
  final Future<Iterable<PropertyAreaModel>> areas;
  bool dropDownBool;
  @override
  _CustomDropDownOneState createState() => _CustomDropDownOneState();
}

class _CustomDropDownOneState extends State<AreasBar> {
  // bool isDropDownOpened = false;
  final keyBarOne = GlobalKey();
  double widthOfBarOne = 400;
  double barheight = 0;
  List _dealAreas = [];
  List dealAreasInBar = [];

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
              // print(snapshot.data!);
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              _dealAreas = snapshot.data!;
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      // caluclateFilterBarHeight();
                      widget.dropDownBool = !widget.dropDownBool;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          OnHoverButtonTwo(
                            builder: (isHovered) {
                              final colorOfBackground =
                                  isHovered ? colorGreyZero : colorGreyOne;
                              return MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Container(
                                  key: keyBarOne,
                                  width: widthOfBarOne,
                                  decoration: BoxDecoration(
                                    color: widget.dropDownBool
                                        ? colorGreyZero
                                        : colorOfBackground,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: widget.dropDownBool
                                          ? colorB
                                          : colorGreyFour,
                                      width: 2,
                                    ),
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 20, 30, 20),
                                  child: Wrap(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            child: Text("اختز المناطق ...",
                                                style: TextStyle(
                                                    color: widget.dropDownBool
                                                        ? colorB
                                                        : colorGreyFour,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            height: 20,
                                          ),
                                          const Spacer(flex: 1),
                                          widget.dropDownBool
                                              ? Icon(Icons.keyboard_arrow_up,
                                                  color: colorB)
                                              : Icon(Icons.keyboard_arrow_down,
                                                  color: colorGreyFour)
                                        ],
                                      ),
                                      for (var dealArea in dealAreasInBar)
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 2, 5, 2),
                                            child: OnHoverButtonTwo(
                                                builder: (isHovered) {
                                              final colorOfText =
                                                  isHovered ? colorA : colorC;
                                              final colorOfBackground =
                                                  isHovered ? colorC : colorB;
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _dealAreas.add(dealArea);
                                                    _dealAreas.sort((a, b) {
                                                      int compare = a
                                                          .governorate.nameAr
                                                          .compareTo(b
                                                              .governorate
                                                              .nameAr);

                                                      if (compare == 0) {
                                                        return a.nameAr
                                                            .compareTo(
                                                                b.nameAr);
                                                      } else {
                                                        return compare;
                                                      }
                                                    });
                                                    dealAreasInBar
                                                        .remove(dealArea);
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: colorOfBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all(
                                                        width: 2,
                                                        color: colorB),
                                                  ),
                                                  height: 35,
                                                  width: 150,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Spacer(flex: 10),
                                                      Text(dealArea.nameAr,
                                                          style: TextStyle(
                                                              color:
                                                                  colorOfText,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14)),
                                                      const Spacer(flex: 10),
                                                      Icon(Icons.close,
                                                          color: colorOfText),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }))
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
                              ? Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  height: 200,
                                  width: widthOfBarOne,
                                  decoration: BoxDecoration(
                                    color: colorGreyZero,
                                    border: Border.all(
                                        color: const Color(0xff00897B),
                                        width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Scrollbar(
                                    child: ListView.builder(
                                      itemCount: _dealAreas.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8.0, 0, 8.0, 0),
                                          child: OnHoverButtonTwo(
                                              builder: (isHovered) {
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
                                                            MaterialStateProperty
                                                                .all(
                                                          colorOfBackground,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                _dealAreas[
                                                                        index]
                                                                    .governorate
                                                                    .nameAr,
                                                                style: TextStyle(
                                                                    color:
                                                                        colorOfButton,
                                                                    fontSize:
                                                                        10)),
                                                            const Spacer(
                                                                flex: 1),
                                                            Text(
                                                                _dealAreas[index]
                                                                        .nameAr +
                                                                    " | " +
                                                                    _dealAreas[
                                                                            index]
                                                                        .nameAr,
                                                                style: TextStyle(
                                                                    color:
                                                                        colorOfButton)),
                                                            const Spacer(
                                                                flex: 1),
                                                            Icon(Icons.add,
                                                                color:
                                                                    colorOfButton),
                                                          ],
                                                        ),
                                                      ),
                                                      onPressed: () =>
                                                          setState(() {
                                                            dealAreasInBar.add(
                                                                _dealAreas[
                                                                    index]);
                                                            _dealAreas.remove(
                                                                _dealAreas[
                                                                    index]);
                                                          })),
                                                ),
                                                Divider(
                                                    height: 1,
                                                    color: colorGreyThree),
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
                  ));
            }
          }
        });
  }
}
