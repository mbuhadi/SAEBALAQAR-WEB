import 'package:daymanager3/services/http.dart';
import 'package:flutter/material.dart';
import 'app_config.dart';
export 'app_config.dart';
import 'package:get/get.dart';
import 'app.dart';
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

  Get.put<LookupController>(LookupController());
  Get.put<AuthController>(AuthController());
  Get.put<OfficeController>(OfficeController());
  Get.put<AdminController>(AdminController());

  MyApp.config = config;
  runApp(MyApp(config));
  // runApp(TestApp(config));
}
