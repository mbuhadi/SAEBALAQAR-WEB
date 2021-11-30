import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../controllers/lookup_controller.dart';
import '../services/saeb_api.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  List dealtypeslist = [];
  // List dealoutlooks = Get.find<LookupController>().loadOutlooks();
  // List dealareas = Get.find<LookupController>().loadAreas();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              child: ListWheelScrollView(
                itemExtent: 40,
                children: Get.find<LookupController>()
                    .dealTypes
                    .map((dealType) => DropdownMenuItem<int>(
                          value: dealType.id,
                          child: Text(dealType.nameAr),
                        ))
                    .toList(),
                useMagnifier: true,
                magnification: 1.5,
                diameterRatio: 0.5,
                perspective: 0.005,
                physics: const FixedExtentScrollPhysics(),
              ),
            ),
            Container(
              width: 200,
              child: ListWheelScrollView(
                itemExtent: 40,
                children: [],
                useMagnifier: true,
                magnification: 1.5,
                diameterRatio: 0.5,
                perspective: 0.005,
                physics: const FixedExtentScrollPhysics(),
              ),
            ),
            Container(
              width: 200,
              child: ListWheelScrollView(
                itemExtent: 40,
                children: [],
                useMagnifier: true,
                magnification: 1.5,
                diameterRatio: 0.5,
                perspective: 0.005,
                physics: const FixedExtentScrollPhysics(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
