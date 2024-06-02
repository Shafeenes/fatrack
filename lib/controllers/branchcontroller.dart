import 'dart:convert';

import 'package:fatracker/models/branch.dart';
import 'package:fatracker/models/branch_alt.dart';
import 'package:fatracker/models/ticket.dart';
import 'package:fatracker/constant/api_consts.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;

class BranchController {
  String jwtKey;
  BranchController({required this.jwtKey});

  Future<List<BranchAlt>> getAllClientBranches(int clientId) async {
    List<BranchAlt> branches = <BranchAlt>[];
    //var headersList = {'Authorization': 'Bearer ${this.jwtKey}'};
    var headersList = {
      'Authorization': 'Bearer ${this.jwtKey}',
      'Content-Type': 'application/json'
    };
    var url =
        Uri.parse("http://10.10.50.75:44318/api/Branch?ClientId=$clientId");

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      branches.addAll(BranchAlt.toList(json.decode(resBody)));
    } else {
      print(res.reasonPhrase);
    }
    return branches;
  }

  Future<String> createBranch(BranchAlt branch) async {
    //var headersList = {'Authorization': 'Bearer ${this.jwtKey}'};
    String message = "";
    var headersList = {
      'Authorization': 'Bearer ${this.jwtKey}',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse("$API_URL/api/Branch?ClientId");

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      message = resBody;
    } else {
      print(res.reasonPhrase);
    }
    return message;
  }

  Future<String> deleteBranch(int branchId) async {
    //var headersList = {'Authorization': 'Bearer ${this.jwtKey}'};
    String message = "";
    var headersList = {
      'Authorization': 'Bearer ${this.jwtKey}',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse("$API_URL/api/Branch?ClientId");

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode({
      "branchId": branchId,
    });
    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      message = resBody;
    } else {
      print(res.reasonPhrase);
    }
    return message;
  }

  Future<String> updateBranch(BranchAlt updateBranch) async {
    //var headersList = {'Authorization': 'Bearer ${this.jwtKey}'};
    String message = "";
    var headersList = {
      'Authorization': 'Bearer ${this.jwtKey}',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse("$API_URL/api/Branch?ClientId");

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(BranchAlt.toJson(updateBranch));
    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      message = resBody;
    } else {
      print(res.reasonPhrase);
    }
    return message;
  }

  // Future<String> updateBranch(BranchAlt) {

  // }

  // Future<Branch> getAllBranches(int clientId) async {
  //   var branch;

  //   var headersList = {
  //     'Accept': 'application/json',
  //     'Authorization':
  //         'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InJhc21peWEudGVjaCIsIk5hbWUiOiJSYXNtaXlhIE5hamVlbSIsIlVzZXJuYW1lIjoicmFzbWl5YS50ZWNoIiwiVXNlcklkIjoicmFzbWl5YS50ZWNoQGZsb3JhZ3JvdXAubmV0IiwiTWVtYmVyT2YiOiJDTj1Qcm9qZWN0IERlcGFydG1lbnQsREM9ZmxvcmFncm91cCxEQz1uZXQiLCJqdGkiOiIxYTY0Yjk2MS03NmQ4LTQ2ZjMtYjAxZS1kYWNmNTlmOTdiZjciLCJuYmYiOjE3MTM3Nzk0NDMsImV4cCI6MTcxMzg2NTg0MywiaWF0IjoxNzEzNzc5NDQzfQ.dmnwbfTOIzDgcD17Gwr1wUgdMNqy1nHAXCYCX93ue8Q'
  //   };
  //   var url =
  //       Uri.parse("http://10.10.50.75:44318/api/Branch?ClientId=$clientId");

  //   var req = http.Request('GET', url);
  //   req.headers.addAll(headersList);

  //   var res = await req.send();
  //   final resBody = await res.stream.bytesToString();

  //   if (res.statusCode >= 200 && res.statusCode < 300) {
  //     print(resBody);
  //     branch = Branch.fromJson(json.decode(resBody));
  //   } else {
  //     print(res.reasonPhrase);
  //   }

  //   return branch;
  // }

  Future<int> create(Branch branch) async {
    int createdBranchId = 0;
    var headersList = {
      'Authorization': 'Bearer ${this.jwtKey}',
      // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InJhc21peWEudGVjaCIsIk5hbWUiOiJSYXNtaXlhIE5hamVlbSIsIlVzZXJuYW1lIjoicmFzbWl5YS50ZWNoIiwiVXNlcklkIjoicmFzbWl5YS50ZWNoQGZsb3JhZ3JvdXAubmV0IiwiTWVtYmVyT2YiOiJDTj1Qcm9qZWN0IERlcGFydG1lbnQsREM9ZmxvcmFncm91cCxEQz1uZXQiLCJqdGkiOiIzOWE2MTVkNC05ODdiLTRkYjAtOGM0OC1jMDFjYzU2NjkxZDgiLCJuYmYiOjE3MTM2ODUzMDcsImV4cCI6MTcxMzY5MjUwNywiaWF0IjoxNzEzNjg1MzA3fQ.sYKCiZRDEZakyZcqd4AsvZr0y_xkWl1qEevPGk9WQi0',
      'Content-Type': 'application/json'
    };

    var url = Uri.parse('$API_URL/api/Tickets');

    var body = {
      "ticketCreateDto": {
        "id": branch.id,
        "branchName": branch.branchName,
        "clientId": branch.clientId,
      }
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
}
