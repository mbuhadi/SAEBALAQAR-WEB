import 'package:get/get.dart';
import '../models/dealer_model.dart';
import '../models/office_model.dart';
import '../services/saeb_api.dart';

class OfficeController extends GetxController {
  Rxn<OfficeProfileModel> office = Rxn<OfficeProfileModel>();

  Future<void> load() async {
    office.value = await SaebAPI.getOfficeForOwner();
  }

  void addDealer(DealerSummaryModel dealer) {
    office.update((val) {
      val!.dealers = [...val.dealers, dealer];
    });
    // update();
  }

  void removeDealer(String phone) {
    office.update((val) {
      val!.dealers.removeWhere((dealer) => dealer.phone == phone);
      val.dealers = List.from(val.dealers);
    });
    // update();
  }
}
