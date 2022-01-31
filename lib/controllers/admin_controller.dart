import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/deal_model.dart';
import '../models/dealer_model.dart';
import '../models/office_model.dart';
import '../models/propertyarea_model.dart';

import '../models/userpermission_model.dart';
import '../services/http.dart';
import 'package:universal_html/html.dart';

class AdminController extends GetxController {
  Rxn<UserPermissionsModel> adminUser = Rxn<UserPermissionsModel>();

  RxList<OfficeModel> offices = <OfficeModel>[].obs;

  Future<void> load() async {
    var res = await Http().get('/admin/permissions');

    if (res.statusCode == HttpStatus.ok) {
      adminUser.value = UserPermissionsModel(
          perms: jsonDecode(utf8.decode(res.bodyBytes)).cast<String, bool>());
      offices.value = await getOffices();
    }
  }

  Future<void> loadOffices() async {
    offices.value = await getOffices();
  }

  bool isAdmin() {
    return adminUser.value != null;
  }

  bool hasPermission(Permissions perm) {
    return adminUser.value!.hasPermission(perm);
  }

  Future<void> admin_logout() async {
    adminUser.value = null;
  }

  Future<List<OfficeModel>> getOffices() async {
    var res = await Http().get('/admin/offices');
    var offices = jsonDecode(utf8.decode(res.bodyBytes)) as List<dynamic>;

    return offices.map((e) => OfficeModel.fromMap(e)).toList();
  }

  Future<List<DealerSummaryModel>> getDealers() async {
    var res = await Http().get('/admin/dealers');
    var dealers = jsonDecode(utf8.decode(res.bodyBytes)) as List<dynamic>;

    return dealers.map((e) => DealerSummaryModel.fromMap(e)).toList();
  }

  Future<List<DealModel>> getDeals() async {
    var res = await Http().get('/admin/deals');
    var deals = jsonDecode(utf8.decode(res.bodyBytes)) as List<dynamic>;
    return deals.map((e) => DealModel.fromMap(e)).toList();
  }

  Future<List<OfficeModel>?> createOffice(
    String name,
    String imageBase64,
    String ownerName,
    String ownerPhone,
  ) async {
    var response = await Http().post('/admin/offices',
        body: jsonEncode({
          "name": name,
          "image": imageBase64,
          "owner": {
            "name": ownerName,
            "phone": ownerPhone,
          }
        }));

    if (response.statusCode != HttpStatus.created) {
      Get.snackbar("Error", response.body,
          colorText: Color(0xFFFEFEFE), backgroundColor: Colors.green);
      return null;
    }
    var offices = jsonDecode(response.body) as List<dynamic>;

    return offices.map((e) => OfficeModel.fromMap(e)).toList();
  }

  Future<List<PropertyAreaModel>> getPropertyAreas() async {
    var res = await Http().get('/admin/propertyarea');
    var deals = jsonDecode(utf8.decode(res.bodyBytes)) as List<dynamic>;

    return deals.map((e) => PropertyAreaModel.fromMap(e)).toList();
  }

  Future<PropertyAreaModel> createPropertyAreas(PropertyAreaModel area) async {
    var response =
        await Http().post('/admin/propertyarea/', body: area.toJson());

    if (response.statusCode == 201) {
      return PropertyAreaModel.fromMap(jsonDecode(response.body));
    }

    throw response.body;
  }

  Future<PropertyAreaModel> updatePropertyArea(
    PropertyAreaModel area,
    int id,
  ) async {
    var response =
        await Http().patch('/admin/propertyarea/$id/', body: area.toJson());

    if (response.statusCode ~/ 200 == 1) {
      return area.copyWith(id: id);
    }

    throw response.body;
  }

  Future<List<PropertyAreaModel>> deletePropertyArea() async {
    var response = await Http().get('/admin/propertyarea');
    var deals = jsonDecode(response.body) as List<dynamic>;

    return deals.map((e) => PropertyAreaModel.fromMap(e)).toList();
  }
}
