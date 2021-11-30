class AppConfig {
  String name;
  String domain;
  String commonPath;
  String? acessToken;
  String? initRoute;
  bool isDev;
  AppConfig({
    required this.name,
    required this.domain,
    required this.commonPath,
    this.acessToken,
    this.initRoute,
    this.isDev = false,
  });
}
