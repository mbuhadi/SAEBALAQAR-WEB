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
import 'pages/profile_page.dart' deferred as dealer;
import 'services/saeb_api.dart';
import 'pages/create_deal_page.dart' deferred as create;
import 'pages/office_page.dart' deferred as office;
import 'pages/payment_result_page.dart';
import 'saeb_icons.dart';
import 'pages/landing_page.dart';
import 'widgets/navbar/onhover.dart';
import 'pages/about_us.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'pages/search_page.dart';
import 'pages/search_page_2.dart';
import 'pages/admin_page.dart' deferred as admin;
import 'pages/search_page_3.dart';
import 'pages/search_page_4.dart';
import 'widgets/colors/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'controllers/lookup_controller.dart';
import 'pages/login_page_two.dart';
// ---------------------------------------------------------
// STOP HERE STOP HERE
// ---------------------------------------------------------

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> nagivator = GlobalKey();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  static late AppConfig config;
  MyApp(AppConfig config) {
    MyApp.config = config;
  }
  Future<void> getTypes() async {
    await Get.find<LookupController>().load();
    // print(Get.find<LookupController>().dealTypes);
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
        // "/": (_) => const DealsPage(),
        "/alldeals": (_) => DealingsList(
              source: SaebAPI.deals(),
              editable: false,
            ),
        "/login": (_) => const LoginPage(),
        '/profile': (_) => FutureBuilder(
            future: dealer.loadLibrary(),
            builder: (_, __) => (__.connectionState != ConnectionState.done)
                ? Center(child: CircularProgressIndicator())
                : dealer.ProfilePage()),
        '/offers': (_) => const OfferPage(),
        '/office': (_) => FutureBuilder(
            future: office.loadLibrary(),
            builder: (_, __) => (__.connectionState != ConnectionState.done)
                ? Center(child: CircularProgressIndicator())
                : office.OfficePage()),
        '/success': (_) => PaymentResultPage(),
        '/': (_) => LandingPage(
              types: SaebAPI.loadTypesForSearch(),
              areas: SaebAPI.loadAreasForSearch(),
            ),
        '/about': (_) => const AboutUs(),
        '/search': (_) => FilterBarOne(),
        '/logintwo': (_) => LoginPageTwo(),
        '/search3': (_) => CustomDropDownTwo(
              types: SaebAPI.loadTypesForSearch(),
              areas: SaebAPI.loadAreasForSearch(),
            ),
        '/search4': (_) => TestDropDown(source: SaebAPI.loadTypesForSearch()),
        '/admin': (_) => FutureBuilder(
            future: admin.loadLibrary(),
            builder: (_, __) => (__.connectionState != ConnectionState.done)
                ? Center(child: CircularProgressIndicator())
                : admin.AdminPage()),
        '/create': (_) => FutureBuilder(
            future: create.loadLibrary(),
            builder: (_, __) => (__.connectionState != ConnectionState.done)
                ? Center(child: CircularProgressIndicator())
                : create.CreateDealPage()),
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
                                      "الرئيسي",
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
                                            "إدارة",
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
                                            "إنشاء",
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
                                            "عروض",
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
                                            "شخصي",
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
                                        "من نحن",
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
                                            "دخول",
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
                                            "خروج",
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
//                                   "سيب العقار",
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
//                   "سيب العقار",
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
        //           "الرئيسي",
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
        //                 "إدارة",
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
        //                 "إنشاء",
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
        //                 "عروض",
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
        //                 "شخصي",
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
        //             "من نحن",
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
        //                 "دخول",
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
        //                 "خروج",
        //                 style: TextStyle(color: colorOfButton),
        //               ),
        //             );
        //           })),
        //     const Spacer(flex: 5),
        //   ],
        // );