import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../Controllers/deal_controller.dart';
import '../deal_card.dart';

class DealsPage extends StatelessWidget {
  const DealsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView(
            children: Get.find<DealController>()
                .deals
                .map((deal) => DealCard(deal: deal))
                .toList()),
      ),
    );
  }
}
