import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/office_controller.dart';
import '../models/dealer_model.dart';
import 'dealings_list.dart';
import '../services/Saeb_API.dart';
import '../widgets/across_app/colors.dart';

class OfficePage extends StatelessWidget {
  const OfficePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var office = Get.find<OfficeController>().office;
    Get.find<OfficeController>().load();
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(12),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: office.value == null
              ? <Widget>[Text('Loading office information...')]
              : [
                  Container(
                    padding: const EdgeInsets.all(12),
                    color: Color(0xFFFEFEFE),
                    child: Row(
                      children: [
                        Image.network(
                          office.value!.imageUrl,
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Container(
                            color: Colors.grey,
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          office.value!.name,
                          style: Theme.of(context).textTheme.headline4,
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text("Dealers",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16, color: colorC)),
                      const SizedBox(
                        width: 16,
                      ),
                      InkWell(
                          onTap: () async {
                            var dealerNameController = TextEditingController();
                            var dealerPhoneController = TextEditingController();

                            var _formKey = GlobalKey<FormState>();
                            var success = await showDialog<bool>(
                                context: context,
                                builder: (_) => Container(
                                      child: Center(
                                        child: Card(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Form(
                                                key: _formKey,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxWidth: 500),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      TextFormField(
                                                          controller:
                                                              dealerNameController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  hintText:
                                                                      "Dealer name"),
                                                          validator: (text) {
                                                            if (text == null ||
                                                                text.isEmpty) {
                                                              return "Required";
                                                            }

                                                            return null;
                                                          }),
                                                      TextFormField(
                                                        controller:
                                                            dealerPhoneController,
                                                        maxLength: 8,
                                                        maxLengthEnforcement:
                                                            MaxLengthEnforcement
                                                                .enforced,
                                                        validator: (text) {
                                                          if (text == null) {
                                                            return "Required field";
                                                          }
                                                          if (!RegExp(r"\d{8}")
                                                              .hasMatch(text))
                                                            return "Must be 8 digits";
                                                        },
                                                        decoration:
                                                            const InputDecoration(
                                                                hintText:
                                                                    "Phone number"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton.icon(
                                                  onPressed: () async {
                                                    if (!_formKey.currentState!
                                                        .validate()) {
                                                      return;
                                                    }
                                                    var result = await SaebAPI
                                                        .addOfficeDealer(
                                                            name:
                                                                dealerNameController
                                                                    .text,
                                                            phone:
                                                                dealerPhoneController
                                                                    .text);
                                                    Navigator.of(_).pop(result);
                                                  },
                                                  icon: Icon(Icons.add,
                                                      color: colorC),
                                                  label: Text("Add")),
                                              const SizedBox(
                                                height: 6,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));

                            if (success == true) {
                              Get.find<OfficeController>()
                                  .addDealer(DealerSummaryModel(
                                phone: dealerPhoneController.text,
                                name: dealerNameController.text,
                              ));
                            }
                          },
                          child: Icon(Icons.add))
                    ],
                  ),
                  SizedBox(
                    height: 120,
                    child: GridView.count(
                      scrollDirection: Axis.horizontal,
                      crossAxisCount: 2,
                      childAspectRatio: .5,
                      children: office.value!.dealers
                          .map((dealer) => Card(
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(dealer.name),
                                        SizedBox(height: 6),
                                        Text(dealer.phone),
                                      ],
                                    ),
                                    if (office.value!.owner.phone !=
                                        dealer.phone)
                                      InkWell(
                                        onTap: () async {
                                          var result = await showDialog<bool>(
                                              context: context,
                                              builder: (_) => Center(
                                                    child: Card(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                                "Are you sure you want to remove ${dealer.name}?"),
                                                            SizedBox(
                                                                height: 20),
                                                            Container(
                                                              constraints:
                                                                  BoxConstraints(
                                                                      maxWidth:
                                                                          400),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  SizedBox(),
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () async {
                                                                        var res =
                                                                            await SaebAPI.deleteOfficeDealer(dealer.phone);
                                                                        Navigator.of(_)
                                                                            .pop(res);
                                                                      },
                                                                      child: Text(
                                                                          "Yes")),
                                                                  TextButton(
                                                                      onPressed:
                                                                          Navigator.of(_)
                                                                              .pop,
                                                                      child:
                                                                          Text(
                                                                        'Cancel',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey),
                                                                      )),
                                                                  SizedBox()
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ));

                                          if (result == true) {
                                            Get.find<OfficeController>()
                                                .removeDealer(dealer.phone);
                                          }
                                        },
                                        child: Icon(Icons.delete),
                                      )
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  Expanded(
                      child: DealingsList(
                          source: SaebAPI.getOfficeDeals(), editable: false))
                ],
        ),
      ),
    ));
  }
}
