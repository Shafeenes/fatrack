// import 'dart:ffi';

import 'package:fatracker/controllers/ticketcontroller.dart';
import 'package:fatracker/models/ticket.dart';
import 'package:fatracker/constant/api_consts.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import "dart:convert";
import 'dart:developer' as developer;

import 'package:http/http.dart';

class AuthController {
  String _token = "";
  Future<String> login(String _userName, String _passWord) async {
    List<Ticket> tickets = [];
    var headersList = {'Content-Type': 'application/json'};
    var url = Uri.parse('$API_URL/api/Account/Login');
    // print("Encoded password : " + base64.encode(utf8.encode(_passWord)));
    var body = {
      "email": _userName,
      "password": base64.encode(utf8.encode(_passWord))
    };

    var req = http.Request('POST', url);

    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    // print("Token : " + json.decode(resBody)["token"]);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      // print("Token : " + _token);
      _token = json.decode(resBody.toString())["token"];
      storeKey_cb(_token, _userName);
      TicketController(jwtKey: _token).getAllTickets().then((ticketData) => {
            for (int i = 0; i < ticketData.length; i++)
              {
                tickets.add(ticketData[i]),
              }
          });

      // print(tickets);
      // storeKey_cb(resBody, _userName);

      // return _token;
    } else {
      // _token = res.reasonPhrase.toString();
      print(res.reasonPhrase);
    }

    // print(resBody);
    return _token;
  }

  Future<String> storeKey_cb(String _token, _userName) async {
    if (_token != null) {
      final storage = new FlutterSecureStorage();
      final callBack = await storage
          .write(key: "access_key", value: _token)
          .then((val) => {_token = _token});
      await storage.write(key: "username", value: _userName).then(
            (val) => {
              _userName = _userName,
            },
          );
    }
    print("Token : " + _token);
    return _token;
  }

  Future<String?> getAccessKey() async {
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: "access_key") as String;
    return value;
  }

  Future<String?> getAccessKeyUserName() async {
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: "username") as String;
    return value;
  }

  Future removeAccessKey() async {
    final storage = new FlutterSecureStorage();
    String? value = await storage.delete(key: "access_key") as String;
    // return value;
  }

  Logout() async {
    List<Ticket> tickets = List.empty();
    String key;
    getAccessKey().then((value) => {
          _token = value as String,
        });
    var headersList = {
      'Authorization': 'Bearer ${this._token}',
      // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InJhc21peWEudGVjaCIsIk5hbWUiOiJSYXNtaXlhIE5hamVlbSIsIlVzZXJuYW1lIjoicmFzbWl5YS50ZWNoIiwiVXNlcklkIjoicmFzbWl5YS50ZWNoQGZsb3JhZ3JvdXAubmV0IiwiTWVtYmVyT2YiOiJDTj1Qcm9qZWN0IERlcGFydG1lbnQsREM9ZmxvcmFncm91cCxEQz1uZXQiLCJqdGkiOiIzOWE2MTVkNC05ODdiLTRkYjAtOGM0OC1jMDFjYzU2NjkxZDgiLCJuYmYiOjE3MTM2ODUzMDcsImV4cCI6MTcxMzY5MjUwNywiaWF0IjoxNzEzNjg1MzA3fQ.sYKCiZRDEZakyZcqd4AsvZr0y_xkWl1qEevPGk9WQi0',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$API_URL/api/Account/logout');

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      removeAccessKey().then((val) => {
            print(val.toString()),
          });
      // print(resBody),
      //_token = jsonDecode(resBody)["token"];
    } else {
      //print(res.reasonPhrase);
    }

    print(resBody);

    return tickets;
  }

  String getToken() {
    return _token;
  }
}
