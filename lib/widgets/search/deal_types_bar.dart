import 'package:daymanager3/widgets/search/deal_areas_bar.dart';
import 'package:flutter/material.dart';
import '../navbar/onhover.dart';
import '../across_app/colors.dart';
import '../../models/propertytype_model.dart';
import '../../models/propertyarea_model.dart';
import '../../controllers/query_controller.dart';
import 'package:get/get.dart';
import '../across_app/size_ratio.dart';

class TypesBarTwo extends StatefulWidget {
  TypesBarTwo({
    Key? key,
    required this.types,
    required this.areas,
    required this.dropDownBool,
  }) : super(key: key);
  final Future<Iterable<PropertyTypeModel>> types;
  final Future<Iterable<PropertyAreaModel>> areas;
  bool dropDownBool;

  @override
  _TypesBarTwoState createState() => _TypesBarTwoState();
}

class _TypesBarTwoState extends State<TypesBarTwo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List _dealTypes = [];
  List<bool> _selections = [];

  double sizeRatio = 1;
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<QueryController>();

    isChoice(chosen, object) {
      return chosen == _dealTypes.indexOf(object);
    }

    return FutureBuilder<dynamic>(
        future: widget.types, // function where you call your api
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          } else {
            if (snapshot.hasError) {
              // print(snapshot.data!);
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              if (displayWidth(context) < 610) {
                sizeRatio = 0.73;
              } else {
                sizeRatio = 1;
              }
              _dealTypes = snapshot.data!;
              _selections = List.generate(_dealTypes.length, (_) => false);
              // print(_dealTypes);
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: colorGreyOne,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Wrap(
                          children: [
                            for (var dealType in _dealTypes)
                              OnHoverButtonTwo(builder: (isHovered) {
                                final colorOfText =
                                    isHovered ? colorA : colorGreyFour;
                                final colorOfBackground = isHovered
                                    ? colorGreyThreeReducedOpacity
                                    : colorGreyOne;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      controller.setType(
                                          _dealTypes.indexOf(dealType));
                                    });
                                  },
                                  child: PhysicalModel(
                                    color: Colors.white,
                                    elevation: isChoice(
                                            controller.type.value, dealType)
                                        ? 8
                                        : 0,
                                    shadowColor: colorB,
                                    borderRadius: BorderRadius.circular(20),
                                    child: AnimatedContainer(
                                      decoration: BoxDecoration(
                                        color: isChoice(
                                                controller.type.value, dealType)
                                            ? colorB
                                            : colorOfBackground,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      duration:
                                          const Duration(milliseconds: 150),
                                      height: 40,
                                      width: 72.6 * sizeRatio,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(dealType.nameAr,
                                              style: TextStyle(
                                                  color: isChoice(
                                                          controller.type.value,
                                                          dealType)
                                                      ? colorC
                                                      : colorOfText,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 81,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AreasBarTwo(
                      areas: widget.areas,
                      dropDownBool: widget.dropDownBool,
                      type: _dealTypes[controller.type.value],
                      type_index: controller.type.value)
                ],
              );
            }
          }
        });
  }
}
