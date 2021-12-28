import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../models/offer_model.dart';
import '../services/http.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({Key? key}) : super(key: key);

  @override
  _OfferPageState createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  @override
  void initState() {
    super.initState();

    Get.find<AuthController>().loadOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          Get.find<AuthController>().offers.map((e) => buildCard(e)).toList(),
    );
  }

  Widget buildCard(OfferModel offer) => SizedBox(
        height: 140,
        child: Card(
          child: Row(
            children: [
              Image.network(
                offer.image,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer.name,
                      style: Get.textTheme.headline4,
                    ),
                    Text("الرصيد ${offer.credit}"),
                    const SizedBox(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (_) => Center(
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text("تأكيد عملية الشراء"),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () async {
                                                  var r = await Http().post(
                                                      '/dealer/offers/${offer.id}',
                                                      body: jsonEncode({
                                                        "redirect_destination":
                                                            Uri.base.toString() +
                                                                "/success"
                                                      }));
                                                  html.window
                                                      .open(r.body, '_self');
                                                  // await Get.find<AuthController>()
                                                  //     .loadProfile();
                                                  // Navigator.of(_).pop();
                                                },
                                                child: const Text("دفع")),
                                            const SizedBox(width: 12),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(_).pop(),
                                              child: Text(
                                                'إلغاء',
                                                style: TextStyle(
                                                    color:
                                                        Get.theme.primaryColor),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                    },
                    child: Text("${offer.price} د.ك")),
              )
            ],
          ),
        ),
      );
}
