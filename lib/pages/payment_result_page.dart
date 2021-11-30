import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentResultPage extends StatelessWidget {
  PaymentResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var dealer = Get.find<AuthController>().dealer.value!;
    return const Scaffold(
      body: Center(
        child: Text(
          "تمت العملية بنجاح",
        ),
      ),
    );
  }
}
