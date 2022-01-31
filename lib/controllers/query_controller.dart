import 'package:get/get.dart';
import '../models/propertyarea_model.dart';
import '../models/propertytype_model.dart';
import '../services/saeb_api.dart';

class QueryController extends GetxController {
  var type = 1.obs;
  var areas = <PropertyAreaModel>[].obs;

  RxList<PropertyTypeModel> initTypes = <PropertyTypeModel>[].obs;
  RxList<PropertyAreaModel> initAreas = <PropertyAreaModel>[].obs;
  var isLoading = true.obs;

  Future<void> load() async {
    // await loadTypes();
    // await loadAreas();
    isLoading.value = false;
  }

  Future<void> loadTypes() async {
    initTypes.value = (await SaebAPI.dealTypes()).toList();
  }

  Future<void> loadAreas() async {
    initAreas.value = (await SaebAPI.dealAreas()).toList();
  }

  void setType(int t) {
    type.value = t;
  }
}
