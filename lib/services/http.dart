import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:universal_html/html.dart';

class Http {
  final String domain;
  final String commonPath;

  static Http? _instance;

  static Http get instance {
    if (_instance == null) {
      throw "Call Http(domain. commonPath) at least once to set instance";
    }

    return _instance!;
  }

  factory Http({
    domain,
    commonPath,
  }) {
    if (_instance == null) {
      _instance = Http._create(domain, commonPath);
    }
    return _instance!;
  }

  Http._create(String domain, String commonPath)
      : this.domain = domain,
        this.commonPath = commonPath;

  void configure(String domain, String commonPath) {
    domain = domain;
    commonPath = commonPath;
  }

  Future<Response> get(String relativeUrl, {bool noAuth = false}) =>
      _sendRequest(relativeUrl, "GET", noAuth: noAuth);

  Future<Response> post(String relativeUrl,
          {String body = "", bool noAuth = false}) =>
      _sendRequest(relativeUrl, "POST", body: body, noAuth: noAuth);
  Future<Response> delete(String relativeUrl, {bool noAuth = false}) =>
      _sendRequest(relativeUrl, "DELETE", noAuth: noAuth);
  Future<Response> put(String relativeUrl,
          {String body = "", bool noAuth = false}) =>
      _sendRequest(relativeUrl, "PUT", body: body, noAuth: noAuth);
  Future<Response> patch(String relativeUrl,
          {String body = "", bool noAuth = false}) =>
      _sendRequest(relativeUrl, "PATCH", body: body, noAuth: noAuth);

  Future<Response> _sendRequest(String relativeUrl, String method,
      {String? body, bool noAuth = false}) async {
    String url = domain + commonPath + relativeUrl;
    print("$method $url");
    Client c = Client();
    var req = Request(method, Uri.parse(url));
    if (!noAuth) {
      req.headers['Authorization'] = "Bearer " + window.localStorage['token']!;
    }
    req.headers[HttpHeaders.contentTypeHeader] = "application/json";
    if (body != null) {
      req.body = body;
    }
    var stream = await c.send(req);
    return await Response.fromStream(stream);
  }
}
