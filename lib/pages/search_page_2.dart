import 'package:flutter/material.dart';
import '../widgets/navbar/onhover.dart';

class CustomDropDownOne extends StatefulWidget {
  const CustomDropDownOne({Key? key}) : super(key: key);

  @override
  _CustomDropDownOneState createState() => _CustomDropDownOneState();
}

class _CustomDropDownOneState extends State<CustomDropDownOne> {
  bool isDropDownOpened = false;
  List itemsInBarOne = [];
  var items = [
    'ONE',
    'TWO',
    'THREE',
    'FOUR',
    'FIVE',
    'SIX',
    'SEVEN',
    'EIGHT',
    'NINE',
    'TEN'
  ];
  final keyBarOne = GlobalKey();
  double widthOfBarOne = 400;
  double barheight = 0;

  void caluclateFilterBarHeight() =>
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          barheight = keyBarOne.currentContext!.size!.height;
        });
      });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        if (isDropDownOpened == true) isDropDownOpened = false;
      }),
      child: Scaffold(
        // backgroundColor: Color(0xFFffa078),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  isDropDownOpened
                      ? Container(
                          padding: EdgeInsets.fromLTRB(0, barheight, 0, 0),
                          height: 200 + barheight,
                          width: widthOfBarOne,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xff00897b), width: 2),
                            color: Colors.teal[20],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Scrollbar(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                  child: TextButton(
                                      child: Text(items[index],
                                          style: const TextStyle(
                                              color: Color(0xff01062e))),
                                      onPressed: () => setState(() {
                                            itemsInBarOne.add(items[index]);
                                            items.remove(items[index]);
                                            caluclateFilterBarHeight();
                                          })),
                                );
                              },
                            ),
                          ))
                      : SizedBox(
                          height: 200 + barheight,
                          width: widthOfBarOne,
                        ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isDropDownOpened = !isDropDownOpened;
                        caluclateFilterBarHeight();
                      });
                    },
                    child: Container(
                      key: keyBarOne,
                      width: widthOfBarOne,
                      decoration: BoxDecoration(
                        color: Color(0xfff7fffb),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xff00897b), width: 2),
                      ),
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: Wrap(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                child: Text("dsqbjkbsqjkbjdwq"),
                                height: 10,
                              ),
                              // isDropDownOpened
                              // ? SizedBox()
                              // : Center(child: Icon(Icons.arrow_drop_down)),
                            ],
                          ),
                          for (var i in itemsInBarOne)
                            OnHoverButton(builder: (isHovered) {
                              final colorOfText = isHovered
                                  ? const Color(0xff00897b)
                                  : Colors.white;
                              final colorOfBackground = isHovered
                                  ? Colors.white
                                  : const Color(0xff00897b);
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        itemsInBarOne.remove(i);
                                        items.add(i);
                                        caluclateFilterBarHeight();
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: colorOfBackground,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                            width: 2,
                                            color: const Color(0xff00897b)),
                                      ),
                                      height: 35,
                                      width: 100,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(i,
                                                style: TextStyle(
                                                    color: colorOfText,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Icon(Icons.close,
                                                color: colorOfText)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// MouseRegion(
//                   cursor: SystemMouseCursors.click,
//                   child: GestureDetector(
//                     onTap: () {
//                       nagivator.currentState!.pushReplacementNamed("/");
//                     },
//                     child: Image.asset('images/Logo2.png',
//                         fit: BoxFit.cover, height: 72),
//                   ),
//                 ),

// onPressed: () => setState(() {
//   itemsInBarOne.remove(i);
//   items.add(i);
//   caluclateFilterBarHeight();
// }),
