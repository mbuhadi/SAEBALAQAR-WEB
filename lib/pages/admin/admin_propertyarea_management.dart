import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import '../../controllers/lookup_controller.dart';
import '../../models/propertyarea_model.dart';
import '../../services/http.dart';
import '../../widgets/formfields/builder_text_field.dart';
import '../../widgets/formfields/form_builder.dart';
import '../../widgets/admin/admin_propertyarea_card.dart';

class AdminPropertyAreaManagement extends StatefulWidget {
  final bool canEdit;
  final bool canDelete;
  final bool canCreate;

  AdminPropertyAreaManagement({
    Key? key,
    this.canEdit = false,
    this.canCreate = false,
    this.canDelete = false,
  }) : super(key: key);

  @override
  _AdminPropertyTypeManagementState createState() =>
      _AdminPropertyTypeManagementState();
}

class _AdminPropertyTypeManagementState
    extends State<AdminPropertyAreaManagement> {
  @override
  Widget build(BuildContext context) {
    var lookup = Get.find<LookupController>();
    return Scaffold(
      body: Obx(
        () => Wrap(
          children: lookup.dealAreas
              .map((e) => AdminPropertyAreaCard(
                    area: e,
                    onEdit: !widget.canEdit
                        ? null
                        : () async {
                            // print("AdminPropertyAreaCard");
                            // Get.dialog(Center(
                            //   child: Card(
                            //     child: Column(
                            //       mainAxisSize: MainAxisSize.min,
                            //       children: [
                            //         FormBuilder(
                            //           title: "Edit Property Area",
                            //           fields: [
                            //             BuilderTextField(
                            //               id: "name_ar",
                            //               label: "Arabic name",
                            //               initValue: e.nameAr,
                            //             ),
                            //             BuilderTextField(
                            //               id: "name_en",
                            //               label: "English name",
                            //               initValue: e.nameEn,
                            //             ),
                            //           ],
                            //           onSubmit: (data) async {
                            //             var body = {};

                            //             if (data['name_ar'] != null &&
                            //                 data['name_ar']!.isNotEmpty &&
                            //                 data["name"] != e.nameAr) {
                            //               body['name_ar'] = data['name_ar'];
                            //             }

                            //             if (data['name_en'] != null &&
                            //                 data['name_en']!.isNotEmpty &&
                            //                 data["name"] != e.nameEn) {
                            //               body['name_en'] = data['name_en'];
                            //             }

                            //             if (body.isEmpty) {
                            //               return "Nothing to update";
                            //             }

                            //             var res = await Http().patch(
                            //                 "/admin/propertyarea/${e.id}",
                            //                 body: jsonEncode(body));

                            //             if (res.statusCode == HttpStatus.ok) {
                            //               Navigator.of(context).pop();

                            //               await lookup.loadAreas();

                            //               return null;
                            //             } else {
                            //               return utf8.decode(res.bodyBytes);
                            //             }
                            //           },
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ));
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
                                        'Deleting property area: ${e.nameAr} will delete all their deals, and dealers. Are you sure?'),
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        var res = await Http().delete(
                                            "/admin/propertyarea/${e.id}");

                                        if (res.statusCode ==
                                            HttpStatus.noContent) {
                                          Navigator.pop(context);
                                          Get.snackbar("Success",
                                              "Dealer has been deleted",
                                              colorText: Color(0xFFFEFEFE),
                                              backgroundColor: Colors.green);

                                          lookup.removeArea(e.id);
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
      ),
      floatingActionButton: !widget.canCreate
          ? null
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                // Get.dialog(Center(
                //   child: Card(
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         FormBuilder(
                //           title: "Create Property Area",
                //           fields: [
                //             BuilderTextField(
                //               id: "name_ar",
                //               label: "Arabic name",
                //             ),
                //             BuilderTextField(
                //               id: "name_en",
                //               label: "English name",
                //             ),
                //           ],
                //           onSubmit: (data) async {
                //             if (data['name_ar'] == null ||
                //                 data['name_ar']!.isEmpty) {
                //               return "Missing Arabic name";
                //             }
                //             if (data['name_en'] == null ||
                //                 data['name_en']!.isEmpty) {
                //               return "Missing English name";
                //             }

                //             var res = await Http().post("/admin/propertyarea",
                //                 body: jsonEncode(data));

                //             if (res.statusCode == HttpStatus.created) {
                //               lookup.addArea(PropertyAreaModel.fromJson(
                //                   utf8.decode(res.bodyBytes)));

                //               Navigator.of(context).pop();
                //               return null;
                //             } else {
                //               return utf8.decode(res.bodyBytes);
                //             }
                //           },
                //         ),
                //       ],
                //     ),
                //   ),
                // ));
              },
            ),
    );
  }
}
