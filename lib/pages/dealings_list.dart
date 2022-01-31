import 'package:flutter/painting.dart';

import '../deal_card.dart';
import '../models/deal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/across_app/colors.dart';
import 'landing_page.dart';
import '../services/saeb_api.dart';

class DealingsList extends StatefulWidget {
  DealingsList({
    Key? key,
    required this.source,
    required this.editable,
  }) : super(key: key);
  final Future<Iterable<DealModel>> source;
  final bool editable;

  @override
  _DealingsListState createState() => _DealingsListState();
}

class _DealingsListState extends State<DealingsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Iterable<DealModel>>(
          future: widget.source,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Spacer(flex: 5),
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_up),
                        iconSize: 50,
                        color: colorC,
                        tooltip: 'العوده الى البحث',
                        onPressed: () {
                          // Navigator.pushReplacementNamed(context, '/');
                          Navigator.of(context).push(_createRoute());
                        },
                      ),
                      Spacer(flex: 1),
                    ],
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff00897b)),
                  ),
                ],
              ));
            }
            if (snapshot.data!.isEmpty) {
              return Center(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      const Spacer(flex: 5),
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_up),
                        iconSize: 50,
                        color: colorC,
                        tooltip: 'العوده الى البحث',
                        onPressed: () {
                          // Navigator.pushReplacementNamed(context, '/');
                          Navigator.of(context).push(_createRoute());
                        },
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  const Text(
                    "لا توجد عروض",
                    style: TextStyle(
                      fontSize: 23,
                      color: Color(0xFFFEFEFE),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_up),
                    iconSize: 50,
                    color: colorC,
                    tooltip: 'العوده الى البحث',
                    onPressed: () {
                      // Navigator.pushReplacementNamed(context, '/');
                      Navigator.of(context).push(_createRoute());
                    },
                  ),
                ],
              ));
            }
            return Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      // Text("تم العثور على",
                      //     style: TextStyle(
                      //         color: colorC,
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.bold)),
                      const Spacer(flex: 5),
                      IconButton(
                        icon: Icon(Icons.keyboard_arrow_up),
                        iconSize: 50,
                        color: colorC,
                        tooltip: 'العوده الى البحث',
                        onPressed: () {
                          // Navigator.pushReplacementNamed(context, '/');
                          Navigator.of(context).push(_createRoute());
                        },
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                  SizedBox(
                    width: 1100,
                    height: 640,
                    child: ListView(
                        children: snapshot.data!
                            .map((deal) => DealCard(
                                  isOwner: widget.editable,
                                  deal: deal,
                                ))
                            .toList()),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => LandingPage(
      types: SaebAPI.loadTypesForSearch(),
      areas: SaebAPI.loadAreasForSearch(),
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, -1.0);
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
