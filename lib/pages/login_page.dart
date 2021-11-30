import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../services/Saeb_API.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  final userNameController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  bool isLoading = false;
  bool verifyingOTP = false;

  @override
  void initState() {
    super.initState();
    userNameController.text = "";
    passwordController.text = "";
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(23.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 20,
                      ),
                      Text('تسجيل دخول',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26)),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        verifyingOTP
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon:
                                          const Icon(Icons.keyboard_arrow_left),
                                      onPressed: () {
                                        setState(() {
                                          verifyingOTP = false;
                                        });
                                      }),
                                ],
                              )
                            : const SizedBox(
                                height: 24,
                              ),
                        TextFormField(
                            enabled: !verifyingOTP,
                            controller: userNameController,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'رقم الهاتف',
                            ),
                            style: verifyingOTP
                                ? const TextStyle(color: Colors.grey)
                                : const TextStyle(color: Colors.black),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال رقم';
                              } else if (value.length != 8) {
                                return 'الرجاء إدخال 8 أرقام';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        if (verifyingOTP)
                          TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال رقم';
                              } else if (value.length != 6) {
                                return "خطأ";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText:
                                    'الرجاء ادخال الرقم السري الذي تم ارساله لهاتفك'),
                          ),
                        if (verifyingOTP)
                          const SizedBox(
                            height: 20,
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    if (!verifyingOTP) {
                                      try {
                                        var error = await SaebAPI.loginOtp(
                                            userNameController.text);
                                        if (error != null) {
                                          Get.snackbar("خطأ", error,
                                              colorText: Colors.white,
                                              backgroundColor: Colors.red);
                                        } else {
                                          setState(() {
                                            verifyingOTP = true;
                                          });
                                        }
                                      } finally {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    } else {
                                      try {
                                        var verification =
                                            await SaebAPI.verifyOtp(
                                                userNameController.text,
                                                passwordController.text);
                                        print(verification);
                                        if (verification == null) {
                                          Navigator.of(context).pop();
                                          Navigator.pushReplacementNamed(
                                              context, '/profile');
                                          print('VERIFIED!!');
                                        } else {
                                          print('error');
                                        }
                                      } finally {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    }
                                  }
                                },
                                child: verifyingOTP
                                    ? const Text("تحقق الرقم السري")
                                    : const Text("ارسل الرقم السري")),
                            const SizedBox(
                              width: 170,
                            ),
                            isLoading
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      SizedBox(
                                        child: CircularProgressIndicator(),
                                        height: 12.0,
                                        width: 12.0,
                                      ),
                                    ],
                                  )
                                : const Text(""),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

validation(value, noOfDigit) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  if (value.length > noOfDigit || value.length < noOfDigit) {
    return 'Please enter $noOfDigit digits';
  }
  return null;
}






                            // verifyingOTP
                            //     ? Row(
                            //         children: [
                            //           TextButton(
                            //               child: const Text(
                            //                   'اعادة ارسال الرقم السري'),
                            //               style: TextButton.styleFrom(
                            //                   primary: Colors.blue,
                            //                   textStyle: const TextStyle(
                            //                     color: Colors.black,
                            //                     fontSize: 15,
                            //                   )),
                            //               onPressed: () async {
                            //                 if (_formKey.currentState!
                            //                     .validate()) {
                            //                   setState(() {
                            //                     isLoading = true;
                            //                   });
                            //                 }
                            //                 try {
                            //                   var error =
                            //                       await SaebAPI.loginOtp(
                            //                           userNameController.text);
                            //                   if (error != null) {
                            //                     Get.snackbar("خطأ", error,
                            //                         colorText: Colors.white,
                            //                         backgroundColor:
                            //                             Colors.red);
                            //                   }
                            //                 } finally {
                            //                   setState(() {
                            //                     isLoading = false;
                            //                   });
                            //                 }
                            //                 ;
                            //               }),
                            //           const SizedBox(
                            //             width: 23,
                            //           ),
                            //         ],
                            //       )
                            //     : const SizedBox(
                            //         width: 170,
                            //       ),