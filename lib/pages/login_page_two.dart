import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../services/Saeb_api.dart';

class LoginPageTwo extends StatefulWidget {
  const LoginPageTwo({Key? key}) : super(key: key);

  @override
  _LoginPageTwoState createState() => _LoginPageTwoState();
}

class _LoginPageTwoState extends State<LoginPageTwo> {
  final userNameController = TextEditingController(text: "INITIAL_TEXT_HERE");
  final passwordController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  bool loadingIcon = false;

  @override
  void initState() {
    super.initState();
    userNameController.text = "11223344";
    passwordController.text = "000000";
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Form(
        key: _formKey,
        child: Center(
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(20),
              constraints: BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: userNameController,
                    decoration: InputDecoration(hintText: "Phone"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال رقم';
                      } else if (value.length != 8) {
                        return 'الرجاء إدخال 8 أرقام';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loadingIcon = true;
                                });
                                try {
                                  var error = await SaebAPI.loginOtp(
                                    userNameController.text,
                                  );
                                  if (error != null) {
                                    Get.snackbar("خطأ", error,
                                        colorText: Colors.white,
                                        backgroundColor: Colors.red);
                                  } else {
                                    Get.snackbar("نجاح", "تم إرسال الرمز السري",
                                        colorText: Colors.white,
                                        backgroundColor: Colors.green);

                                    passwordController.text = "";
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              title: Text(
                                                  "الرجاء إدخال الرمز السري OTP"),
                                              content: TextFormField(
                                                controller: passwordController,
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      var verification =
                                                          await SaebAPI.verifyOtp(
                                                              userNameController
                                                                  .text,
                                                              passwordController
                                                                  .text);
                                                      if (verification ==
                                                          null) {
                                                        Navigator.of(_).pop();
                                                        Navigator
                                                            .pushReplacementNamed(
                                                                context,
                                                                '/profile');
                                                      } else {
                                                        print('error');
                                                      }
                                                    },
                                                    child: Text("تحقق")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text("إلغاء"))
                                              ],
                                            ));
                                  }
                                } finally {
                                  setState(() {
                                    loadingIcon = false;
                                  });
                                }
                              }
                            },
                            child: loadingIcon
                                ? CircularProgressIndicator()
                                : Text("تسجيل دخول")),
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
