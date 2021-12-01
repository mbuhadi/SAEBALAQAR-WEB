// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'app_config.dart';
import 'controllers/admin_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/office_controller.dart';
import 'pages/dealings_list.dart';
import 'pages/deals_page.dart';
import 'pages/login_page.dart';
import 'pages/offer_page.dart';
import 'pages/profile_page.dart';
import 'services/saeb_api.dart';
import 'pages/create_deal_page.dart';
import 'pages/office_page.dart';
import 'pages/payment_result_page.dart';
import 'saeb_icons.dart';
import 'pages/landing_page.dart';
import 'widgets/navbar/onhover.dart';
import 'pages/about_us.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'pages/search_page.dart';
import 'pages/admin_page.dart';
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
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Saeb',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        fontFamily: "Almarai",
        // backgroundColor: const Color(0xFFE6F2FC),
        backgroundColor: const Color(0xFF01062e),
        // scaffoldBackgroundColor: const Color(0xFFE6F2FC),
        scaffoldBackgroundColor: const Color(0xFF01062e),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(primary: Colors.white)),
      ),

      // primaryColor: Colors.white,

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
        '/profile': (_) => const ProfilePage(),
        '/offers': (_) => const OfferPage(),
        '/createdeal': (_) => const CreateDealPage(),
        '/office': (_) => const OfficePage(),
        '/success': (_) => PaymentResultPage(),
        '/': (_) => const LandingPage(),
        '/about': (_) => const AboutUs(),
        // '/search': (_) => const SearchPage(),
        '/admin': (_) => const AdminPage(),
        '/create': (_) => const CreateDealPage(),
      },
      navigatorKey: nagivator,
      builder: (_, child) {
        var loggedIn = Get.find<AuthController>().isLoggedIn;
        var myOffice = Get.find<OfficeController>().office;
        var adminUser = Get.find<AdminController>().adminUser;
        AppBar mobileAppBarOne = AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
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
                child: Image.asset('images/Logo2.png',
                    fit: BoxFit.cover, height: 72),
              ),
              const Spacer(flex: 1),
            ],
            iconTheme: const IconThemeData(
              color: Color(0xff01062e),
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
                            child: Image.asset('images/Logo2.png'),
                            fit: BoxFit.fitWidth,
                          )),
                          OnHoverButton(builder: (isHovered) {
                            final colorOfButton = isHovered
                                ? Colors.teal[600]
                                : const Color(0xff01062e);
                            final colorOfBackground = isHovered
                                ? Colors.grey[200]
                                : const Color(0x00ffffff);
                            return TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      colorOfBackground)),
                              onPressed: () => nagivator.currentState!
                                  .pushReplacementNamed("/"),
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
                                  final colorOfButton = isHovered
                                      ? Colors.teal[600]
                                      : const Color(0xff01062e);
                                  final colorOfBackground = isHovered
                                      ? Colors.grey[100]
                                      : const Color(0x00ffffff);
                                  return TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                colorOfBackground)),
                                    onPressed: () => nagivator.currentState!
                                        .pushReplacementNamed("/admin"),
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
                                  final colorOfButton = isHovered
                                      ? Colors.teal[600]
                                      : const Color(0xff01062e);
                                  final colorOfBackground = isHovered
                                      ? Colors.grey[200]
                                      : const Color(0x00ffffff);
                                  return TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                colorOfBackground)),
                                    onPressed: () => nagivator.currentState!
                                        .pushReplacementNamed("/create"),
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
                                    onPressed: () => nagivator.currentState!
                                        .pushReplacementNamed("/offers"),
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
                                  final colorOfButton = isHovered
                                      ? Colors.teal[600]
                                      : const Color(0xff01062e);
                                  final colorOfBackground = isHovered
                                      ? Colors.grey[200]
                                      : const Color(0x00ffffff);
                                  return TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                colorOfBackground)),
                                    onPressed: () => nagivator.currentState!
                                        .pushReplacementNamed("/profile"),
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
                            final colorOfButton = isHovered
                                ? Colors.teal[600]
                                : const Color(0xff01062e);
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
                                  context
                                      .findRootAncestorStateOfType<
                                          DrawerControllerState>()
                                      ?.close();
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
                                  final colorOfButton = isHovered
                                      ? Colors.teal[600]
                                      : const Color(0xff01062e);
                                  final colorOfBackground = isHovered
                                      ? Colors.grey[200]
                                      : const Color(0x00ffffff);
                                  return TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                colorOfBackground)),
                                    onPressed: () => nagivator.currentState!
                                        .pushReplacementNamed("/login"),
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
                                  final colorOfButton = isHovered
                                      ? Colors.teal[600]
                                      : const Color(0xff01062e);
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
//                                       color: Color(0xff01062e), fontSize: 20),
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
//                   isHovered ? Colors.teal[600] : Color(0xff01062e);
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
        //   backgroundColor: Colors.white,
        //   leadingWidth: 300,
        //   leading: SizedBox(
        //     child: Image.asset('images/Logo2.png'),
        //     height: 60,
        //   ),
        //   actions: [
        //     const Spacer(flex: 15),
        //     OnHoverButton(builder: (isHovered) {
        //       final colorOfButton =
        //           isHovered ? Colors.teal[600] : const Color(0xff01062e);
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
        //                 isHovered ? Colors.teal[600] : const Color(0xff01062e);
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
        //                 isHovered ? Colors.teal[600] : Color(0xff01062e);
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
        //                 isHovered ? Colors.teal[600] : Color(0xff01062e);
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
        //                 isHovered ? Colors.teal[600] : Color(0xff01062e);
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
        //           isHovered ? Colors.teal[600] : Color(0xff01062e);
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
        //                 isHovered ? Colors.teal[600] : Color(0xff01062e);
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
        //                 isHovered ? Colors.teal[600] : Color(0xff01062e);
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