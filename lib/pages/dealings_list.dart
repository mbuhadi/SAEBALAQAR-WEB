import '../deal_card.dart';
import '../models/deal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.data!.isEmpty) {
              return const Center(
                  child: Text(
                "لا توجد عروض",
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.white,
                ),
              ));
            }
            return Center(
              child: SizedBox(
                width: 1200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                      children: snapshot.data!
                          .map((deal) => DealCard(
                                isOwner: widget.editable,
                                deal: deal,
                              ))
                          .toList()),
                ),
              ),
            );
          }),
    );
  }
}
