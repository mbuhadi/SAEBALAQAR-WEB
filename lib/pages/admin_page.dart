import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../controllers/admin_controller.dart';
import 'admin/admin_deal_management.dart';
import 'admin/admin_dealer_management.dart';
import 'admin/admin_office_management.dart';
import 'admin/admin_propertyarea_management.dart';
import 'admin/admin_propertyoutlook_management.dart';
import 'admin/admin_propertytype_management.dart';
import '../widgets/colors/colors.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class PermissionTabModel {
  final String label;
  final Widget Function(bool, bool, bool) widget;
  PermissionTabModel({
    required this.label,
    required this.widget,
  });
}

var permToPage = {
  "OFFICE": PermissionTabModel(
      label: "Offices",
      widget: (c, e, d) => AdminOfficeManagement(
            canCreate: c,
            canEdit: e,
            canDelete: d,
          )),
  "DEALER": PermissionTabModel(
      label: "Dealers",
      widget: (c, e, d) => AdminDealerManagement(
            canCreate: c,
            canEdit: e,
            canDelete: d,
          )),
  "DEAL": PermissionTabModel(
      label: "Deals",
      widget: (c, e, d) => AdminDealManagement(
            canDelete: d,
          )),
  "PROPERTY": PermissionTabModel(
      label: "Types",
      widget: (c, e, d) => AdminPropertyTypeManagement(
            canCreate: c,
            canEdit: e,
            canDelete: d,
          )),
  "AREA": PermissionTabModel(
      label: "Areas",
      widget: (c, e, d) => AdminPropertyAreaManagement(
            canCreate: c,
            canEdit: e,
            canDelete: d,
          )),
  "OUTLOOK": PermissionTabModel(
      label: "Outlooks",
      widget: (c, e, d) => AdminPropertyOutlookManagement(
            canCreate: c,
            canEdit: e,
            canDelete: d,
          )),
};

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    var adminUser = Get.find<AdminController>();
    var perms = adminUser.adminUser.value!.perms;

    double unitHeightValue = MediaQuery.of(context).size.width * 0.01;
    double multiplier = 2;

    List<String> viewablePages = perms.entries
        .where((e) => e.key.endsWith("VIEW") && e.value)
        .where((e) => permToPage
            .containsKey(e.key.substring(0, e.key.length - "_VIEW".length)))
        .map((e) => e.key.substring(0, e.key.length - "_VIEW".length))
        .toList();

    return DefaultTabController(
      length: viewablePages.length,
      child: Scaffold(
        backgroundColor: colorC,
        body: Column(
          children: [
            Container(
              height: 50,
              child: Expanded(
                child: TabBar(
                  tabs: viewablePages
                      .map((e) => Padding(
                            padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
                            child: Text(
                              permToPage[e]!.label,
                              style: TextStyle(
                                  fontSize: multiplier * unitHeightValue,
                                  color: Colors.black),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: permToPage.entries
                    .map((e) => e.value.widget(
                          perms[e.key + "_CREATE"]!,
                          perms[e.key + "_EDIT"]!,
                          perms[e.key + "_DELETE"]!,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
