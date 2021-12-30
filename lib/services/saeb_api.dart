import 'dart:convert';

import '../controllers/auth_controller.dart';
import '../models/propertyarea_model.dart';
import '../models/deal_model.dart';
import '../models/propertytype_model.dart';
import '../models/dealer_model.dart';
import '../models/office_model.dart';
import '../models/propertyoutlook_model.dart';
import '../services/http.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class SaebAPI {
  static Future<String?> loginOtp(String phone) async {
    var res = await Http()
        .post("/auth/otp/", noAuth: true, body: jsonEncode({"phone": phone}));

    if (res.statusCode == 201 || res.statusCode == 200) {
      return null;
    } else {
      return res.body;
    }
  }

  static Future<String?> verifyOtp(String phone, String otp) async {
    print("2");
    var res = await Http().post("/auth/verify/",
        noAuth: true, body: jsonEncode({"phone": phone, "otp": otp}));
    print("3");
    if (res.statusCode == 201) {
      print("4");
      await _processAuthorization(
          jsonDecode(utf8.decode(res.bodyBytes))['access']);
      print("14");
      return null;
    } else {
      return utf8.decode(res.bodyBytes);
    }
  }

  static Future<void> _processAuthorization(String token) async {
    print("5");
    await Get.find<AuthController>().login(token);
    print("13");
  }

  static Future<Iterable<DealModel>> deals() async {
    // var res = await Http().get("/deals/", noAuth: true);
    var res = await http
        .get(Uri.parse('https://saebbackend.herokuapp.com/api/deals/'));
    var body = jsonDecode(utf8.decode(res.bodyBytes));
    var results = body["results"] as List<dynamic>;
    print(results);
    try {
      var l = results.map((d) => DealModel.fromMap(d)).toList();
      return l;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  static Future<DealerModel> profile() async {
    var res = await Http().get("/dealer/deals");
    return DealerModel.fromJson(res.body);
  }

  static Future<List<DealModel>> myDeals() async {
    var res = await Http().get("/dealer/deals");
    var body =
        jsonDecode(utf8.decode(res.bodyBytes))['results'] as List<dynamic>;
    return body.map((d) => DealModel.fromMap(d)).toList();
  }

  static Future<String?> createDeal(
      String description, int dealType, int dealArea, int outlook) async {
    var res = await Http().post("/dealer/deals/",
        body: jsonEncode({
          "description": description,
          "property_type": dealType,
          "property_area": dealArea,
          "property_outlook": outlook
        }));
    if (res.statusCode == 201) return null;
    return res.body;
  }

  static Future<String?> deleteDeal(int id) async {
    var res = await Http().delete("/dealer/deals/$id/");
    if (res.statusCode == 200) {
      await Get.find<AuthController>().loadProfile();
      return null;
    }
    return res.body;
  }

  static Future<String?> relistDeal(int id) async {
    var res = await Http().put("/dealer/deals/$id/");
    if (res.statusCode == 200) {
      await Get.find<AuthController>().loadProfile();
      return null;
    }
    return res.body;
  }

  static Future<Iterable<PropertyTypeModel>> loadTypesForSearch() async {
    var res = await http
        .get(Uri.parse('https://saebbackend.herokuapp.com/api/deals/types'));
    var body = jsonDecode(utf8.decode(res.bodyBytes));
    // print(body);
    var results = body as List<dynamic>;
    // print(results);
    try {
      var l = results.map((d) => PropertyTypeModel.fromMap(d)).toList();
      return l;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  static Future<Iterable<PropertyAreaModel>> loadAreasForSearch() async {
    var res = await http
        .get(Uri.parse('https://saebbackend.herokuapp.com/api/deals/areas'));
    var body = jsonDecode(utf8.decode(res.bodyBytes));
    // print(body);
    var results = body as List<dynamic>;
    // print(results);
    try {
      var l = results.map((d) => PropertyAreaModel.fromMap(d)).toList();
      return l;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  static Future<Iterable<PropertyTypeModel>> dealTypes() async {
    var res = await Http().get("/deals/types");
    var body = jsonDecode(utf8.decode(res.bodyBytes)) as List<dynamic>;
    return body.map((d) => PropertyTypeModel.fromMap(d)).toList();
  }

  static Future<Iterable<PropertyAreaModel>> dealAreas() async {
    var res = await Http().get("/deals/areas");
    var body = jsonDecode(utf8.decode(res.bodyBytes)) as List<dynamic>;
    return body.map((d) => PropertyAreaModel.fromMap(d)).toList();
  }

  static Future<Iterable<PropertyOutlookModel>> outlooks() async {
    var res = await Http().get("/deals/outlooks");
    var body = jsonDecode(utf8.decode(res.bodyBytes)) as List<dynamic>;
    return body.map((d) => PropertyOutlookModel.fromMap(d)).toList();
  }

  static Future<OfficeProfileModel?> getOfficeForOwner() async {
    var res = await Http().get("/office");
    if (res.statusCode != 200) {
      return null;
    }
    return OfficeProfileModel.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
  }

  static Future<List<DealModel>> getOfficeDeals() async {
    var res = await Http().get("/office/deals");

    return (jsonDecode(utf8.decode(res.bodyBytes)) as List)
        .map((e) => DealModel.fromMap(e))
        .toList();
  }

  static Future<bool> addOfficeDealer({
    required String phone,
    required String name,
  }) async {
    var res = await Http().post("/office/dealers",
        body: jsonEncode({
          "phone": phone,
          "name": name,
        }));

    return res.statusCode == 201;
  }

  static Future<bool> deleteOfficeDealer(String phone) async {
    var res = await Http().delete("/office/dealers/$phone");

    return res.statusCode == 200;
  }
}

Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}
