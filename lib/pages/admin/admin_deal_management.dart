import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import '../../controllers/admin_controller.dart';
import '../../models/deal_model.dart';
import '/../services/http.dart';

import '/widgets/admin/admin_deal_card.dart';

class AdminDealManagement extends StatefulWidget {
  final bool canDelete;

  AdminDealManagement({
    Key? key,
    this.canDelete = false,
  }) : super(key: key);

  @override
  _AdminDealManagementState createState() => _AdminDealManagementState();
}

class _AdminDealManagementState extends State<AdminDealManagement> {
  late bool isLoading;
  late List<DealModel> deals;

  @override
  void initState() {
    super.initState();
    isLoading = true;

    Get.find<AdminController>().getDeals().then((value) => setState(() {
          isLoading = false;
          deals = value.cast<DealModel>();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            body: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 1200,
                child: Wrap(
                  children: deals
                      .map((e) => AdminDealCard(
                            deal: e,
                            onDelete: !widget.canDelete
                                ? null
                                : () async {
                                    Get.dialog(Center(
                                      child: Card(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                'Deleting deal: ${e.id} will delete all their deals, and deals. Are you sure?'),
                                            ElevatedButton.icon(
                                              onPressed: () async {
                                                var res = await Http().delete(
                                                    "/admin/deals/${e.id}");

                                                if (res.statusCode ==
                                                    HttpStatus.noContent) {
                                                  Navigator.pop(context);
                                                  Get.snackbar("Success",
                                                      "Dealer has been deleted",
                                                      colorText: Colors.white,
                                                      backgroundColor:
                                                          Colors.green);

                                                  setState(() {
                                                    deals = deals
                                                        .where(
                                                            (o) => o.id != e.id)
                                                        .toList();
                                                  });
                                                } else {
                                                  Navigator.pop(context);
                                                  Get.snackbar(
                                                      "Error",
                                                      utf8.decode(
                                                          res.bodyBytes),
                                                      colorText: Colors.white,
                                                      backgroundColor:
                                                          Colors.red);
                                                }
                                              },
                                              icon: Icon(Icons.delete),
                                              label: Text("Yes"),
                                              style: ElevatedButton.styleFrom(
                                                  primary:
                                                      Get.theme!.errorColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                                  },
                          ))
                      .toList(),
                ),
              ),
            ),
          );
  }
}
