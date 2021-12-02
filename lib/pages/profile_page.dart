import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

import '../services/saeb_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dealings_list.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dealer = Get.find<AuthController>().dealer.value!;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(12),
            color: Color(0xFFFEFEFE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dealer.name,
                  style: Get.textTheme.headline4,
                ),
                Text(dealer.phone),
                Row(
                  children: [
                    Text("الرصيد المتبقي: ${dealer.remaining}"),
                    const SizedBox(width: 4),
                  ],
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "عروضي",
              style: TextStyle(
                fontSize: 28,
                color: Color(0xFFFEFEFE),
              ),
            ),
          ),
          Expanded(
            child: DealingsList(
              source: SaebAPI.myDeals(),
              editable: true,
            ),
          ),
        ],
      ),
    );
  }
}
