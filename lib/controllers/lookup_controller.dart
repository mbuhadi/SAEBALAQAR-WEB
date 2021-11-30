import 'package:get/get.dart';
import '../models/propertytype_model.dart';
import '../models/propertyarea_model.dart';
import '../models/propertyoutlook_model.dart';
import '../services/saeb_api.dart';

class LookupController extends GetxController {
  RxList<PropertyTypeModel> dealTypes = <PropertyTypeModel>[].obs;
  RxList<PropertyAreaModel> dealAreas = <PropertyAreaModel>[].obs;
  RxList<PropertyOutlookModel> dealOutlooks = <PropertyOutlookModel>[].obs;

  Future<void> load() async {
    await loadTypes();
    await loadAreas();
    await loadOutlooks();
  }

  Future<void> loadTypes() async {
    dealTypes.value = (await SaebAPI.dealTypes()).toList();
  }

  Future<void> loadAreas() async {
    dealAreas.value = (await SaebAPI.dealAreas()).toList();
  }

  Future<void> loadOutlooks() async {
    dealOutlooks.value = (await SaebAPI.outlooks()).toList();
  }

  void addType(PropertyTypeModel type) {
    dealTypes.add(type);
  }

  void addArea(PropertyAreaModel area) {
    dealAreas.add(area);
  }

  void addOutlook(PropertyOutlookModel outlook) {
    dealOutlooks.add(outlook);
  }

  void removeType(int id) {
    dealTypes.removeWhere((e) => e.id == id);
  }

  void removeArea(int id) {
    dealAreas.removeWhere((e) => e.id == id);
  }

  void removeOutlook(int id) {
    dealOutlooks.removeWhere((e) => e.id == id);
  }
}
