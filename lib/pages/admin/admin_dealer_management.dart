import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import '../../controllers/admin_controller.dart';
import '../../models/dealer_model.dart';
import '../../services/http.dart';
import '../../widgets/formfields/builder_select_field.dart';
import '../../widgets/formfields/builder_text_field.dart';
import '../../widgets/formfields/form_builder.dart';
import '../../widgets/admin/admin_dealer_card.dart';

class AdminDealerManagement extends StatefulWidget {
  final bool canEdit;
  final bool canDelete;
  final bool canCreate;

  AdminDealerManagement({
    Key? key,
    this.canEdit = false,
    this.canCreate = false,
    this.canDelete = false,
  }) : super(key: key);

  @override
  _AdminDealerManagementState createState() => _AdminDealerManagementState();
}

class _AdminDealerManagementState extends State<AdminDealerManagement> {
  late bool isLoading;
  late List<DealerSummaryModel> dealers;

  @override
  void initState() {
    super.initState();
    isLoading = true;

    Get.find<AdminController>().getDealers().then((value) => setState(() {
          isLoading = false;
          dealers = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff00897b)),
          ))
        : Scaffold(
            body: Wrap(
              children: dealers
                  .map((e) => AdminDealerCard(
                        dealer: e,
                        onEdit: !widget.canEdit
                            ? null
                            : () async {
                                print("AdminDealerCard");
                                Get.dialog(Center(
                                  child: Card(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        FormBuilder(
                                          title: "Edit Dealer",
                                          fields: [
                                            // BuilderTextField(
                                            //   id: "name",
                                            //   label: "Dealer name",
                                            //   initValue: e.name,
                                            // ),
                                          ],
                                          onSubmit: (data) async {
                                            var body = {};

                                            if (data['name'] != null &&
                                                data['name']!.isNotEmpty &&
                                                data["name"] != e.name) {
                                              body['name'] = data['name'];
                                            } else {
                                              return "Missing name";
                                            }

                                            var res = await Http().patch(
                                                "/admin/dealers/${e.phone}",
                                                body: jsonEncode(body));

                                            if (res.statusCode ==
                                                HttpStatus.ok) {
                                              Navigator.of(context).pop();

                                              Get.find<AdminController>()
                                                  .getDealers()
                                                  .then((value) => setState(() {
                                                        isLoading = false;
                                                        dealers = value;
                                                      }));

                                              return null;
                                            } else {
                                              return utf8.decode(res.bodyBytes);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                              },
                        onDelete: !widget.canDelete
                            ? null
                            : () async {
                                Get.dialog(Center(
                                  child: Card(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            'Deleting dealer: ${e.phone} will delete all their deals, and dealers. Are you sure?'),
                                        ElevatedButton.icon(
                                          onPressed: () async {
                                            var res = await Http().delete(
                                                "/admin/dealers/${e.phone}");

                                            if (res.statusCode ==
                                                HttpStatus.noContent) {
                                              Navigator.pop(context);
                                              Get.snackbar("Success",
                                                  "Dealer has been deleted",
                                                  colorText: Color(0xFFFEFEFE),
                                                  backgroundColor:
                                                      Colors.green);

                                              setState(() {
                                                dealers = dealers
                                                    .where((o) =>
                                                        o.phone != e.phone)
                                                    .toList();
                                              });
                                            } else {
                                              Navigator.pop(context);
                                              Get.snackbar("Error",
                                                  utf8.decode(res.bodyBytes),
                                                  colorText: Color(0xFFFEFEFE),
                                                  backgroundColor: Colors.red);
                                            }
                                          },
                                          icon: Icon(Icons.delete),
                                          label: Text("Yes"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Get.theme.errorColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                              },
                      ))
                  .toList(),
            ),
            floatingActionButton: !widget.canCreate
                ? null
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () async {
                      Get.dialog(Center(
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FormBuilder(
                                title: "Create Dealer",
                                fields: [
                                  BuilderSelectField(
                                      id: "office",
                                      label: "Office",
                                      items: Get.find<AdminController>()
                                          .offices
                                          .map((e) => SelectItem(
                                                value: e.id.toString(),
                                                label: e.name,
                                              ))
                                          .toList()),
                                  // BuilderTextField(
                                  //   id: "phone",
                                  //   label: "Phone number",
                                  // ),
                                  // BuilderTextField(
                                  //   id: "name",
                                  //   label: "Dealer name",
                                  // ),
                                ],
                                onSubmit: (data) async {
                                  var res = await Http().post("/admin/dealers",
                                      body: jsonEncode({
                                        "phone": data['phone'],
                                        "name": data['name'],
                                        "office": data['office'],
                                      }));

                                  if (res.statusCode == HttpStatus.created) {
                                    Navigator.of(context).pop();

                                    Get.find<AdminController>()
                                        .getDealers()
                                        .then((value) => setState(() {
                                              isLoading = false;
                                              dealers = value;
                                            }));

                                    return null;
                                  } else {
                                    return utf8.decode(res.bodyBytes);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ));
                    },
                  ),
          );
  }
}
