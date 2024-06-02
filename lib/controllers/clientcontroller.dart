import 'dart:convert';

import 'package:fatracker/models/branch.dart';
import 'package:fatracker/models/branch_alt.dart';
import 'package:fatracker/models/client_alt.dart';
import 'package:fatracker/models/ticket.dart';
import 'package:fatracker/constant/api_consts.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;

class ClientController {
  String jwtKey;
  ClientController({required this.jwtKey});

  Future<List<ClientAlt>> getAllClients() async {
    List<ClientAlt> clients = <ClientAlt>[];
    //var headersList = {'Authorization': 'Bearer ${this.jwtKey}'};
    var headersList = {
      'Authorization': 'Bearer ${this.jwtKey}',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$API_URL/api/Client');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      clients.addAll(ClientAlt.toList(json.decode(resBody)));
    } else {
      print(res.reasonPhrase);
    }
    return clients;
  }

  Future<int> create(String clientName) async {
    int createdBranchId = 0;
    var headersList = {
      'Authorization': 'Bearer ${this.jwtKey}',
      // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InJhc21peWEudGVjaCIsIk5hbWUiOiJSYXNtaXlhIE5hamVlbSIsIlVzZXJuYW1lIjoicmFzbWl5YS50ZWNoIiwiVXNlcklkIjoicmFzbWl5YS50ZWNoQGZsb3JhZ3JvdXAubmV0IiwiTWVtYmVyT2YiOiJDTj1Qcm9qZWN0IERlcGFydG1lbnQsREM9ZmxvcmFncm91cCxEQz1uZXQiLCJqdGkiOiIzOWE2MTVkNC05ODdiLTRkYjAtOGM0OC1jMDFjYzU2NjkxZDgiLCJuYmYiOjE3MTM2ODUzMDcsImV4cCI6MTcxMzY5MjUwNywiaWF0IjoxNzEzNjg1MzA3fQ.sYKCiZRDEZakyZcqd4AsvZr0y_xkWl1qEevPGk9WQi0',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$API_URL/api/Tickets');

    var body = {
      "createDto": {"clientName": clientName}
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (resBody.isNotEmpty) {
        createdBranchId = resBody as int;
      }
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }

    return createdBranchId;
  }

  Future<String> updateClient(int clientId, String clientName) async {
    String msg = '';
    var headersList = {
      'Authorization': 'Bearer ${this.jwtKey}',
      // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InJhc21peWEudGVjaCIsIk5hbWUiOiJSYXNtaXlhIE5hamVlbSIsIlVzZXJuYW1lIjoicmFzbWl5YS50ZWNoIiwiVXNlcklkIjoicmFzbWl5YS50ZWNoQGZsb3JhZ3JvdXAubmV0IiwiTWVtYmVyT2YiOiJDTj1Qcm9qZWN0IERlcGFydG1lbnQsREM9ZmxvcmFncm91cCxEQz1uZXQiLCJqdGkiOiIzOWE2MTVkNC05ODdiLTRkYjAtOGM0OC1jMDFjYzU2NjkxZDgiLCJuYmYiOjE3MTM2ODUzMDcsImV4cCI6MTcxMzY5MjUwNywiaWF0IjoxNzEzNjg1MzA3fQ.sYKCiZRDEZakyZcqd4AsvZr0y_xkWl1qEevPGk9WQi0',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$API_URL/api/Tickets');

    var body = {
      "updateDto": {"clientName": clientName, "id": clientId}
    };

    var req = http.Request('PUT', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (resBody.isNotEmpty) {
        msg = resBody;
      }
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }

    return msg;
  }

  Future<String> deleteClient(int clientId) async {
    String msg = "";
    var headersList = {
      'Authorization': 'Bearer ${this.jwtKey}',
      // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InJhc21peWEudGVjaCIsIk5hbWUiOiJSYXNtaXlhIE5hamVlbSIsIlVzZXJuYW1lIjoicmFzbWl5YS50ZWNoIiwiVXNlcklkIjoicmFzbWl5YS50ZWNoQGZsb3JhZ3JvdXAubmV0IiwiTWVtYmVyT2YiOiJDTj1Qcm9qZWN0IERlcGFydG1lbnQsREM9ZmxvcmFncm91cCxEQz1uZXQiLCJqdGkiOiIzOWE2MTVkNC05ODdiLTRkYjAtOGM0OC1jMDFjYzU2NjkxZDgiLCJuYmYiOjE3MTM2ODUzMDcsImV4cCI6MTcxMzY5MjUwNywiaWF0IjoxNzEzNjg1MzA3fQ.sYKCiZRDEZakyZcqd4AsvZr0y_xkWl1qEevPGk9WQi0',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$API_URL/api/Client/$clientId');

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (resBody.isNotEmpty) {
        msg = resBody;
      }
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }

    return msg;
  }
}
