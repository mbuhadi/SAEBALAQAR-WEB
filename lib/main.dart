import 'package:daymanager3/services/http.dart';
import 'package:flutter/material.dart';
import 'app_config.dart';
export 'app_config.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'controllers/deal_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/lookup_controller.dart';
import 'controllers/office_controller.dart';
import 'controllers/admin_controller.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:universal_html/html.dart';
import 'pages/dealings_list.dart';
import 'services/saeb_api.dart';

void main() {
  startApp(AppConfig(
    name: "Heroku",
    domain: "https://saebbackend.herokuapp.com",
    commonPath: "/api",
    isDev: true,
  ));
}

void startApp(AppConfig config) {
  // print("Running using ${config.name} configuration");

  timeago.setLocaleMessages('ar', timeago.ArMessages());

  Http(domain: config.domain, commonPath: config.commonPath);

  if (config.acessToken != null) {
    window.localStorage['token'] = config.acessToken!;
  }
  Get.put<DealController>(DealController());
  Get.put<LookupController>(LookupController());
  Get.put<AuthController>(AuthController());
  Get.put<OfficeController>(OfficeController());
  Get.put<AdminController>(AdminController());

  MyApp.config = config;
  runApp(MyApp(config));
  // runApp(TestApp(config));
}

class TestApp extends StatelessWidget {
  final GlobalKey<NavigatorState> nagivator = GlobalKey();
  static late AppConfig config;
  // const TestApp({Key? key}) : super(key: key);
  TestApp(AppConfig config) {
    TestApp.config = config;
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialRoute: config.initRoute ?? "/",
        routes: {
          // "/": (_) => const DealsPage(),
          "/": (_) => DealingsList(
                source: SaebAPI.deals(),
                editable: false,
              ),
        },
        builder: (_, child) {
          return MaterialApp(
            home: Scaffold(
              drawer: const Material(child: Drawer()),
              appBar: AppBar(),
            ),
          );
        });
  }
}
