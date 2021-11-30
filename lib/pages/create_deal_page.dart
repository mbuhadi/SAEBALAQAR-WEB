import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../controllers/auth_controller.dart';
import '../controllers/lookup_controller.dart';
import '../services/saeb_api.dart';

class CreateDealPage extends StatefulWidget {
  const CreateDealPage({Key? key}) : super(key: key);

  @override
  _CreateDealPageState createState() => _CreateDealPageState();
}

class _CreateDealPageState extends State<CreateDealPage> {
  final description = TextEditingController(text: "");

  final _formKey = GlobalKey<FormState>();
  int? selectedDealType;
  int? selectedArea;
  int? selectedOutlook;

  bool loadingIcon = false;

  @override
  void dispose() {
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue[50],
      body: Form(
        key: _formKey,
        child: Center(
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(20),
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButtonFormField<int>(
                      validator: (value) {
                        if (value == null) {
                          return 'field required';
                        }
                        return null;
                      },
                      isExpanded: true,
                      value: selectedArea,
                      hint: Text("Select area"),
                      onChanged: (id) => setState(() => selectedArea = id),
                      items: Get.find<LookupController>()
                          .dealAreas
                          .map((dealType) => DropdownMenuItem<int>(
                                value: dealType.id,
                                child: Text(dealType.nameAr),
                              ))
                          .toList()),
                  DropdownButtonFormField<int>(
                      validator: (value) {
                        if (value == null) {
                          return 'field required';
                        }
                        return null;
                      },
                      isExpanded: true,
                      value: selectedDealType,
                      hint: Text("Select type"),
                      onChanged: (id) => setState(() => selectedDealType = id),
                      items: Get.find<LookupController>()
                          .dealTypes
                          .map((dealType) => DropdownMenuItem<int>(
                                value: dealType.id,
                                child: Text(dealType.nameAr),
                              ))
                          .toList()),
                  DropdownButtonFormField<int>(
                      validator: (value) {
                        if (value == null) {
                          return 'field required';
                        }
                        return null;
                      },
                      isExpanded: true,
                      value: selectedOutlook,
                      hint: Text("Select outlook"),
                      onChanged: (id) => setState(() => selectedOutlook = id),
                      items: Get.find<LookupController>()
                          .dealOutlooks
                          .map((outlook) => DropdownMenuItem<int>(
                                value: outlook.id,
                                child: Text(outlook.nameAr),
                              ))
                          .toList()),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                    controller: description,
                    decoration: const InputDecoration(hintText: "Description"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loadingIcon = true;
                                });
                                try {
                                  var error = await SaebAPI.createDeal(
                                    description.text,
                                    selectedDealType!,
                                    selectedArea!,
                                    selectedOutlook!,
                                  );
                                  print("response: $error");
                                  print(
                                      "description.text: ${description.text}");
                                  print("SelectedDealType: $selectedDealType");

                                  if (error != null) {
                                    Get.snackbar("Error", error,
                                        colorText: Colors.white,
                                        backgroundColor: Colors.red);
                                  } else {
                                    Get.find<AuthController>().loadProfile();
                                    description.clear();
                                    Get.snackbar("Success", "Deal Created!",
                                        colorText: Colors.white,
                                        backgroundColor: Colors.green);

                                    setState(() {
                                      loadingIcon = false;
                                      selectedDealType = null;
                                      selectedArea = null;
                                      selectedOutlook = null;
                                      description.text = "";
                                    });
                                  }
                                } finally {}
                              }
                            },
                            child: loadingIcon
                                ? CircularProgressIndicator()
                                : Text("Create")),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
