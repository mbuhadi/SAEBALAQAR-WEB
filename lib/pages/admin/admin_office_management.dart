import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import '../../controllers/admin_controller.dart';
import '../../models/office_model.dart';
import '../../services/http.dart';
import '../../widgets/formfields/builder_image_field.dart';
import '../../widgets/formfields/builder_text_field.dart';
import '../../widgets/formfields/form_builder.dart';
import '../../widgets/admin/admin_office_card.dart';

class AdminOfficeManagement extends StatefulWidget {
  final bool canEdit;
  final bool canDelete;
  final bool canCreate;

  AdminOfficeManagement({
    Key? key,
    this.canEdit = false,
    this.canCreate = false,
    this.canDelete = false,
  }) : super(key: key);

  @override
  _AdminOfficeManagementState createState() => _AdminOfficeManagementState();
}

class _AdminOfficeManagementState extends State<AdminOfficeManagement> {
  late bool isLoading;
  late List<OfficeModel> offices;

  @override
  void initState() {
    super.initState();
    isLoading = true;

    Get.find<AdminController>().getOffices().then((value) => setState(() {
          isLoading = false;
          offices = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            body: Wrap(
              children: offices
                  .map((e) => AdminOfficeCard(
                        office: e,
                        onEdit: !widget.canEdit
                            ? null
                            : () async {
                                Get.dialog(Center(
                                  child: Card(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        FormBuilder(
                                          title: "Edit Office",
                                          fields: [
                                            BuilderTextField(
                                              id: "owner",
                                              label: "Owner phone",
                                              initValue: e.owner,
                                            ),
                                            BuilderTextField(
                                              id: "name",
                                              label: "Office name",
                                              initValue: e.name,
                                            ),
                                            BuilderImageField(
                                              id: "image",
                                              label: "Office Image",
                                              initValue: e.image,
                                            ),
                                          ],
                                          onSubmit: (data) async {
                                            var body = {};

                                            if (data['name'] != null &&
                                                data["name"] != e.name) {
                                              body['name_ar'] = data['name'];
                                            }
                                            if (data['owner'] != null &&
                                                data["owner"] != e.owner) {
                                              body['owner'] = data['owner'];
                                            }
                                            if (data['image'] != null &&
                                                data["image"] != e.image) {
                                              body['image'] = data['image'];
                                            }

                                            body['name_en'] = "no name";

                                            var res = await Http().patch(
                                                "/admin/offices/${e.id}",
                                                body: jsonEncode(body));

                                            if (res.statusCode ==
                                                HttpStatus.ok) {
                                              Navigator.of(context).pop();

                                              Get.find<AdminController>()
                                                  .getOffices()
                                                  .then((value) => setState(() {
                                                        isLoading = false;
                                                        offices = value;
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
                                            'Deleting office: ${e.name} will delete all their deals, and dealers. Are you sure?'),
                                        ElevatedButton.icon(
                                          onPressed: () async {
                                            var res = await Http().delete(
                                                "/admin/offices/${e.id}");

                                            if (res.statusCode ==
                                                HttpStatus.noContent) {
                                              Navigator.pop(context);
                                              Get.snackbar("Success",
                                                  "Office has been deleted",
                                                  colorText: Colors.white,
                                                  backgroundColor:
                                                      Colors.green);

                                              setState(() {
                                                offices = offices
                                                    .where((o) => o.id != e.id)
                                                    .toList();
                                              });
                                            } else {
                                              Navigator.pop(context);
                                              Get.snackbar("Error",
                                                  utf8.decode(res.bodyBytes),
                                                  colorText: Colors.white,
                                                  backgroundColor: Colors.red);
                                            }
                                          },
                                          icon: Icon(Icons.delete),
                                          label: Text("Yes"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Get.theme!.errorColor),
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
                              Text('Create Office'),
                              FormBuilder(
                                title: "Create Office",
                                fields: [
                                  BuilderTextField(
                                    id: "owner_name",
                                    label: "Owner name",
                                  ),
                                  BuilderTextField(
                                    id: "owner_phone",
                                    label: "Owner phone",
                                  ),
                                  BuilderTextField(
                                    id: "office_name",
                                    label: "Office name",
                                  ),
                                  BuilderImageField(
                                    id: "image",
                                    label: "Office Image",
                                  ),
                                ],
                                onSubmit: (data) async {
                                  var res = await Http().post("/admin/offices",
                                      body: jsonEncode({
                                        "name_ar": data['office_name'],
                                        "name_en": data['office_name'],
                                        'image': data['image'],
                                        "owner": {
                                          "phone": data['owner_phone'],
                                          "name": data['owner_name'],
                                        }
                                      }));

                                  if (res.statusCode == HttpStatus.created) {
                                    Navigator.of(context).pop();

                                    Get.find<AdminController>()
                                        .getOffices()
                                        .then((value) => setState(() {
                                              isLoading = false;
                                              offices = value;
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
