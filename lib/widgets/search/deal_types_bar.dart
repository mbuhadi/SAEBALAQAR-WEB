import 'package:flutter/material.dart';
import '../navbar/onhover.dart';
import '../colors/colors.dart';
import '../../models/propertytype_model.dart';

class TypesBar extends StatefulWidget {
  const TypesBar({
    Key? key,
    required this.types,
  }) : super(key: key);
  final Future<Iterable<PropertyTypeModel>> types;

  @override
  _TypesBarState createState() => _TypesBarState();
}

class _TypesBarState extends State<TypesBar> {
  List _dealTypes = [];
  List<bool> _selections = [];
  int _chosen = 0;
  @override
  Widget build(BuildContext context) {
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
              _dealTypes = snapshot.data!;
              _selections = List.generate(_dealTypes.length, (_) => false);
              return Container(
                decoration: BoxDecoration(
                  color: colorGreyOne,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Wrap(
                  children: [
                    for (var dealType in _dealTypes)
                      OnHoverButtonTwo(builder: (isHovered) {
                        final colorOfText = isHovered ? colorA : colorGreyFour;
                        final colorOfBackground =
                            isHovered ? colorGreyThree : colorGreyOne;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _chosen = _dealTypes.indexOf(dealType);
                            });
                          },
                          child: PhysicalModel(
                            color: Colors.white,
                            elevation: isChoice(_chosen, dealType) ? 8 : 0,
                            shadowColor: colorB,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isChoice(_chosen, dealType)
                                    ? colorB
                                    : colorOfBackground,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 40,
                              width: 69,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(dealType.nameAr,
                                      style: TextStyle(
                                          color: isChoice(_chosen, dealType)
                                              ? colorC
                                              : colorOfText,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14)),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                  ],
                ),
              );
            }
          }
        });
  }
}
