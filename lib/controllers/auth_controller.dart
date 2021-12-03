import 'dart:convert';

import 'package:get/get.dart';
import 'admin_controller.dart';
import 'lookup_controller.dart';
import 'office_controller.dart';
import '../models/dealer_model.dart';
import '../models/offer_model.dart';
import '../services/http.dart';
import 'package:universal_html/html.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;

  Rxn<DealerModel> dealer = Rxn<DealerModel>();

  var offers = <OfferModel>[].obs;

  AuthController() : super() {
    if (hasToken()) {
      login(window.localStorage['token']!);
    }
  }

  bool hasToken() {
    return window.localStorage['token'] != null;
  }

  Future<void> logout() async {
    window.localStorage.remove("token");
    isLoggedIn.value = false;
  }

  Future<void> loadProfile() async {
    var response = await Http().get('/dealer/');
    dealer.value = DealerModel.fromJson(response.body);
  }

  Future<void> loadOffers() async {
    var offersResp = await Http().get("/dealer/offers");

    offers.value = jsonDecode(offersResp.body)
        .map((e) => OfferModel.fromMap(e))
        .toList()
        .cast<OfferModel>();
  }

  Future<void> login(String token) async {
    isLoggedIn.value = true;
    window.localStorage['token'] = token;

    var response = await Http().get('/dealer/');
    if (response.statusCode == HttpStatus.ok) {
      dealer.value = DealerModel.fromJson(response.body);
      await loadOffers();
    }
    await loadProfile();
    await Get.find<LookupController>().load();
    // await Get.find<OfficeController>().load();
    await Get.find<AdminController>().load();
  }
}
