// ignore_for_file: file_names
import 'package:daymanager3/models/propertytype_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'app_config.dart';
import 'controllers/admin_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/office_controller.dart';
import 'pages/dealings_list.dart';
import 'pages/login_page.dart';
import 'pages/offer_page.dart';
// import 'pages/profile_page.dart' deferred as dealer;
import 'pages/profile_page.dart';
import 'services/saeb_api.dart';
import 'pages/create_deal_page.dart' deferred as create;
import 'pages/create_deal_page.dart';
// import 'pages/office_page.dart' deferred as office;
import 'pages/office_page.dart';
import 'pages/payment_result_page.dart';
import 'saeb_icons.dart';
import 'pages/landing_page.dart';
import 'widgets/navbar/onhover.dart';
import 'pages/about_us.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
// import 'pages/admin_page.dart' deferred as admin;
import 'pages/admin_page.dart';
import 'widgets/across_app/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'controllers/lookup_controller.dart';
import 'controllers/query_controller.dart';

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> nagivator = GlobalKey();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  static late AppConfig config;
  MyApp(AppConfig config) {
    MyApp.config = config;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Saeb Alalqar",
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        fontFamily: "Almarai",
        // backgroundColor: const Color(0xFFE6F2FC),
        backgroundColor: colorA,
        // scaffoldBackgroundColor: const Color(0xFFE6F2FC),
        scaffoldBackgroundColor: colorA,
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(primary: Color(0xFFFEFEFE))),
      ),

      // primaryColor: Color(0xFFFEFEFE),

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale("en", "US"),
        Locale("ar", "KW"),
      ],
      locale: const Locale('ar', 'KW'),
      initialRoute: config.initRoute ?? "/",
      routes: {
        "/results": (_) => DealingsList(
              source: SaebAPI.deals(""),
              editable: false,
            ),
        "/login": (_) => const LoginPage(),
        '/profile': (_) => ProfilePage(),
        '/offers': (_) => const OfferPage(),
        '/office': (_) => const OfficePage(),
        '/success': (_) => PaymentResultPage(),
        '/': (_) => LandingPage(
              types: SaebAPI.loadTypesForSearch(),
              areas: SaebAPI.loadAreasForSearch(),
            ),
        '/about': (_) => const AboutUs(),
        '/admin': (_) => AdminPage(),
        '/create': (_) => CreateDealPage(),
      },
      navigatorKey: nagivator,
      builder: (_, child) {
        var loggedIn = Get.find<AuthController>().isLoggedIn;
        var myOffice = Get.find<OfficeController>().office;
        var adminUser = Get.find<AdminController>().adminUser;
        AppBar mobileAppBarOne = AppBar(
            elevation: 1,
            backgroundColor: const Color(0xFFFEFEFE),
            leadingWidth: 200,
            leading: IconButton(
              icon: const Icon(Icons.menu,
                  size: 40), // change this size and style
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            ),
            toolbarHeight: 73,
            actions: [
              const Spacer(flex: 8),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      nagivator.currentState!.pushReplacementNamed("/");
                    },
                    child: Image.asset('images/Logo2.png',
                        fit: BoxFit.cover, height: 72),
                  ),
                ),
              ),
              const Spacer(flex: 1),
            ],
            iconTheme: IconThemeData(
              color: colorA,
            ));
        return Overlay(initialEntries: [
          OverlayEntry(
              builder: (context) => Scaffold(
                    drawer: Drawer(
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        children: [
                          DrawerHeader(
                            child: FittedBox(
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    nagivator.currentState!
                                        .pushReplacementNamed("/");
                                    _scaffoldKey.currentState!.openEndDrawer();
                                  },
                                  child: Image.asset('images/Logo2.png'),
                                ),
                              ),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          OnHoverButton(builder: (isHovered) {
                            final colorOfButton =
                                isHovered ? Colors.teal[600] : colorA;
                            final colorOfBackground = isHovered
                                ? Colors.grey[200]
                                : const Color(0x00ffffff);
                            return TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      colorOfBackground)),
                              onPressed: () {
                                nagivator.currentState!
                                    .pushReplacementNamed("/");
                                _scaffoldKey.currentState!.openEndDrawer();
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Icon(Icons.home, color: colorOfButton),
                                    const SizedBox(width: 13),
                                    Text(
                                      "??????????????",
                                      style: TextStyle(
                                          color: colorOfButton, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          Obx(() => adminUser.value == null
                              ? const SizedBox(
                                  height: 0,
                                  width: 0,
                                )
                              : OnHoverButton(builder: (isHovered) {
                                  final colorOfButton =
                                      isHovered ? Colors.teal[600] : colorA;
                                  final colorOfBackground = isHovered
                                      ? Colors.grey[100]
                                      : const Color(0x00ffffff);
                                  return TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                colorOfBackground)),
                                    onPressed: () {
                                      nagivator.currentState!
                                          .pushReplacementNamed("/admin");
                                      _scaffoldKey.currentState!
                                          .openEndDrawer();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 15),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 20),
                                          Icon(Icons.verified_user,
                                              color: colorOfButton),
                                          const SizedBox(width: 13),
                                          Text(
                                            "??????????",
                                            style: TextStyle(
                                              color: colorOfButton,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          Obx(() => loggedIn.value == false
                              ? const SizedBox(
                                  height: 0,
                                  width: 0,
                                )
                              : OnHoverButton(builder: (isHovered) {
                                  final colorOfButton =
                                      isHovered ? Colors.teal[600] : colorA;
                                  final colorOfBackground = isHovered
                                      ? Colors.grey[200]
                                      : const Color(0x00ffffff);
                                  return TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                colorOfBackground)),
                                    onPressed: () {
                                      nagivator.currentState!
                                          .pushReplacementNamed("/create");
                                      _scaffoldKey.currentState!
                                          .openEndDrawer();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 15),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 20),
                                          Icon(Icons.create,
                                              color: colorOfButton),
                                          const SizedBox(width: 13),
                                          Text(
                                            "??????????",
                                            style: TextStyle(
                                                color: colorOfButton,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          Obx(() => loggedIn.value == false
                              ? const SizedBox(
                                  height: 0,
                                  width: 0,
                                )
                              : OnHoverButton(builder: (isHovered) {
                                  final colorOfButton = isHovered
                                      ? Colors.teal[600]
                                      : Colors.orange;
                                  final colorOfBackground = isHovered
                                      ? Colors.grey[200]
                                      : const Color(0x00ffffff);
                                  return TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                colorOfBackground)),
                                    onPressed: () {
                                      nagivator.currentState!
                                          .pushReplacementNamed("/offers");
                                      _scaffoldKey.currentState!
                                          .openEndDrawer();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 15),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 20),
                                          Icon(Icons.add, color: colorOfButton),
                                          const SizedBox(width: 13),
                                          Text(
                                            "????????",
                                            style: TextStyle(
                                                color: colorOfButton,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          Obx(() => loggedIn.value == false
                              ? const SizedBox(
                                  height: 0,
                                  width: 0,
                                )
                              : OnHoverButton(builder: (isHovered) {
                                  final colorOfButton =
                                      isHovered ? Colors.teal[600] : colorA;
                                  final colorOfBackground = isHovered
                                      ? Colors.grey[200]
                                      : const Color(0x00ffffff);
                                  return TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                colorOfBackground)),
                                    onPressed: () {
                                      nagivator.currentState!
                                          .pushReplacementNamed("/profile");
                                      _scaffoldKey.currentState!
                                          .openEndDrawer();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 15),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 20),
                                          Icon(Icons.person_pin,
                                              color: colorOfButton),
                                          const SizedBox(width: 13),
                                          Text(
                                            "????????",
                                            style: TextStyle(
                                                color: colorOfButton,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          OnHoverButton(builder: (isHovered) {
                            final colorOfButton =
                                isHovered ? Colors.teal[600] : colorA;
                            final colorOfBackground = isHovered
                                ? Colors.grey[200]
                                : const Color(0x00ffffff);
                            return TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        colorOfBackground)),
                                onPressed: () {
                                  nagivator.currentState!
                                      .popAndPushNamed("/about");
                                  _scaffoldKey.currentState!.openEndDrawer();
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 20),
                                      Icon(Icons.info, color: colorOfButton),
                                      const SizedBox(width: 13),
                                      Text(
                                        "???? ??????",
                                        style: TextStyle(
                                            color: colorOfButton, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ));
                          }),
                          Obx(() => loggedIn.value == false
                              ? OnHoverButton(builder: (isHovered) {
                                  final colorOfButton =
                                      isHovered ? Colors.teal[600] : colorA;
                                  final colorOfBackground = isHovered
                                      ? Colors.grey[200]
                                      : const Color(0x00ffffff);
                                  return TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                colorOfBackground)),
                                    onPressed: () {
                                      nagivator.currentState!
                                          .pushReplacementNamed("/login");
                                      _scaffoldKey.currentState!
                                          .openEndDrawer();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 15),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 20),
                                          Icon(IcoFontIcons.login,
                                              color: colorOfButton),
                                          const SizedBox(width: 13),
                                          Text(
                                            "????????",
                                            style: TextStyle(
                                              color: colorOfButton,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                              : OnHoverButton(builder: (isHovered) {
                                  final colorOfButton =
                                      isHovered ? Colors.teal[600] : colorA;
                                  final colorOfBackground = isHovered
                                      ? Colors.grey[200]
                                      : const Color(0x00ffffff);
                                  return TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                colorOfBackground)),
                                    onPressed: () {
                                      nagivator.currentState!
                                          .pushReplacementNamed("/login");
                                      Get.find<AuthController>().logout();
                                      Get.find<AdminController>()
                                          .admin_logout();
                                      _scaffoldKey.currentState!
                                          .openEndDrawer();
                                      const AlertDialog(
                                          title: Text('Logout Successful!'));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 15),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 20),
                                          Icon(IcoFontIcons.logout,
                                              color: colorOfButton),
                                          const SizedBox(width: 13),
                                          Text(
                                            "????????",
                                            style: TextStyle(
                                                color: colorOfButton,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                        ],
                      ),
                    ),
                    key: _scaffoldKey,
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(75.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 1200) {
                            return mobileAppBarOne;
                          } else if (constraints.maxWidth > 800 &&
                              constraints.maxWidth < 1200) {
                            return mobileAppBarOne;
                          } else {
                            return mobileAppBarOne;
                          }
                        },
                      ),
                    ),
                    body: child,
                  ))
        ]);
      },
    );
  }
}


// TextButton(
//                                 child: const Text(
//                                   "?????? ????????????",
//                                   style: TextStyle(
//                                       color: colorA, fontSize: 20),
//                                 ),
//                                 onPressed: () {
//                                   nagivator.currentState!
//                                       .pushReplacementNamed("/");
//                                   Navigator.of(context).pop();
//                                   context
//                                       .findRootAncestorStateOfType<
//                                           DrawerControllerState>()
//                                       ?.close();
//                                 }),





// OnHoverButton(builder: (isHovered) {
//               final colorOfButton =
//                   isHovered ? Colors.teal[600] : colorA;
//               return TextButton(
//                 onPressed: () =>
//                     nagivator.currentState!.pushReplacementNamed("/"),
//                 child: Text(
//                   "?????? ????????????",
//                   style: TextStyle(color: colorOfButton),
//                 ),
//               );
//             }),








        // AppBar DesktopNavbar = AppBar(
        //   iconTheme: const IconThemeData(color: Color(0xFF040036)),
        //   elevation: 1,
        //   backgroundColor: Color(0xFFFEFEFE),
        //   leadingWidth: 300,
        //   leading: SizedBox(
        //     child: Image.asset('images/Logo2.png'),
        //     height: 60,
        //   ),
        //   actions: [
        //     const Spacer(flex: 15),
        //     OnHoverButton(builder: (isHovered) {
        //       final colorOfButton =
        //           isHovered ? Colors.teal[600] : const colorA;
        //       return TextButton(
        //         onPressed: () =>
        //             nagivator.currentState!.pushReplacementNamed("/"),
        //         child: Text(
        //           "??????????????",
        //           style: TextStyle(color: colorOfButton),
        //         ),
        //       );
        //     }),
        //     const Spacer(flex: 36),
        //     Obx(() => adminUser.value == null
        //         ? const SizedBox(width: 0)
        //         : OnHoverButton(builder: (isHovered) {
        //             final colorOfButton =
        //                 isHovered ? Colors.teal[600] : const colorA;
        //             return TextButton(
        //               onPressed: () => nagivator.currentState!
        //                   .pushReplacementNamed("/admin"),
        //               child: Text(
        //                 "??????????",
        //                 style: TextStyle(color: colorOfButton),
        //               ),
        //             );
        //           })),
        //     const Spacer(flex: 1),
        //     Obx(() => loggedIn.value == false
        //         ? const SizedBox(width: 0)
        //         : OnHoverButton(builder: (isHovered) {
        //             final colorOfButton =
        //                 isHovered ? Colors.teal[600] : colorA;
        //             return TextButton(
        //               onPressed: () => nagivator.currentState!
        //                   .pushReplacementNamed("/create"),
        //               child: Text(
        //                 "??????????",
        //                 style: TextStyle(color: colorOfButton),
        //               ),
        //             );
        //           })),
        //     const Spacer(flex: 1),
        //     Obx(() => loggedIn.value == false
        //         ? Container()
        //         : OnHoverButton(builder: (isHovered) {
        //             final colorOfButton =
        //                 isHovered ? Colors.teal[600] : colorA;
        //             return TextButton(
        //               onPressed: () => nagivator.currentState!
        //                   .pushReplacementNamed("/offers"),
        //               child: Text(
        //                 "????????",
        //                 style: TextStyle(color: colorOfButton),
        //               ),
        //             );
        //           })),
        //     const Spacer(flex: 1),
        //     Obx(() => loggedIn.value == false
        //         ? const SizedBox(width: 0)
        //         : OnHoverButton(builder: (isHovered) {
        //             final colorOfButton =
        //                 isHovered ? Colors.teal[600] : colorA;
        //             return TextButton(
        //               onPressed: () => nagivator.currentState!
        //                   .pushReplacementNamed("/profile"),
        //               child: Text(
        //                 "????????",
        //                 style: TextStyle(color: colorOfButton),
        //               ),
        //             );
        //           })),
        //     const Spacer(flex: 1),
        //     OnHoverButton(builder: (isHovered) {
        //       final colorOfButton =
        //           isHovered ? Colors.teal[600] : colorA;
        //       return TextButton(
        //           onPressed: () {
        //             nagivator.currentState!.pushReplacementNamed("/about");
        //           },
        //           child: Text(
        //             "???? ??????",
        //             style: TextStyle(color: colorOfButton),
        //           ));
        //     }),
        //     const Spacer(flex: 1),
        //     Obx(() => loggedIn.value == false
        //         ? OnHoverButton(builder: (isHovered) {
        //             final colorOfButton =
        //                 isHovered ? Colors.teal[600] : colorA;
        //             return TextButton(
        //               onPressed: () => nagivator.currentState!
        //                   .pushReplacementNamed("/login"),
        //               child: Text(
        //                 "????????",
        //                 style: TextStyle(color: colorOfButton),
        //               ),
        //             );
        //           })
        //         : OnHoverButton(builder: (isHovered) {
        //             final colorOfButton =
        //                 isHovered ? Colors.teal[600] : colorA;
        //             return TextButton(
        //               onPressed: () {
        //                 nagivator.currentState!.pushReplacementNamed("/login");
        //                 Get.find<AuthController>().logout();
        //                 Get.find<AdminController>().admin_logout();
        //               },
        //               child: Text(
        //                 "????????",
        //                 style: TextStyle(color: colorOfButton),
        //               ),
        //             );
        //           })),
        //     const Spacer(flex: 5),
        //   ],
        // );