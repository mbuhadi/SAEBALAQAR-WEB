import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/deal_model.dart';

class DealController extends GetxController {
  var isLoading = true.obs;
  var deals = <DealModel>[].obs;

  @override
  void onInit() async {
    await fetchDeals();
    super.onInit();
  }

  Future<void> fetchDeals() async {
    isLoading(true);
    try {
      var res = await http
          .get(Uri.parse('https://saebbackend.herokuapp.com/api/deals/'));
      Map data = jsonDecode(utf8.decode(res.bodyBytes));
      List theResults = data['results'];

      var deals = theResults
          .map((e) => DealModel.fromMap(e))
          .cast<DealModel>()
          .toList();

      this.deals.assignAll(deals);
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: st);
    } finally {
      isLoading(false);
    }
  }
}
