import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:fatracker/constant/api_consts.dart';

class SSLVerify {
  final String headerString;
  final X509Certificate? cert;
  final String path;
  final int port;
  final String method;
  final String host;
  final Object body;

  bool isVerifiedSSLReq = false;

  SSLVerify(
      {required this.headerString,
      this.cert,
      required this.body,
      required this.method,
      required this.host,
      required this.path,
      required this.port});

  // bool _sslVerify(X509Certificate cert, String url, int port) {
  //   // You SSL verification logic here by
  //   isVerifiedSSLReq = true;
  //   return isVerifiedSSLReq;
  // }

  bool _sslVerify(X509Certificate cert, String host, int port) => true;

  getResponse() async {
    // if (isVerifiedSSLReq) {
    var uri =
        Uri(scheme: "https", host: "10.10.50.75", port: 44317, path: this.path);

    if (this.path.isNotEmpty) {
      HttpClient client = new HttpClient()..badCertificateCallback = _sslVerify;
      // final request = await client.postUrl(uri);

      var request = await client.postUrl(uri);
      request.headers.set(
          HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
      request.followRedirects = false;
      request.write(jsonEncode(body));
      final response = await request.close();
      return response;
    }
    return null;
  }
}
