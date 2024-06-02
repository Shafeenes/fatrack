// import 'dart:ffi';

import 'dart:convert';
import 'dart:io';

import 'package:fatracker/models/ticket.dart';
import 'package:fatracker/constant/api_consts.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;

class TicketController {
  String jwtKey;
  TicketController({required this.jwtKey});

  Future<List<Ticket>> getAllTickets() async {
    // print("Ticket controller key : " + this.jwtKey);
    List<Ticket> tickets = [];

    var headersList = {
      'Authorization': 'Bearer ${this.jwtKey}',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$API_URL/api/Tickets/listAllAssignedToUser');

    var body = {"pageNumber": 0, "pageSize": 100};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      // var ticketVals = json.decode(resBody)["items"] as List;
      var data = (json.decode(resBody.toString())["items"]) as List;

      for (int i = 0; i < data.length; i++) {
        print(data[i]);
        tickets.add(Ticket.fromJson(data[i]));
      }

      // print(tickets[0]);
    } else {
      print(res.reasonPhrase);
    }

    return tickets;
  }

  Future<Ticket?> getTicketById(int id) async {
    var ticket;

    var headersList = {
      'Authorization': 'Bearer ${this.jwtKey}',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$API_URL/api/Tickets/' + id.toString());

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      // var ticketVals = json.decode(resBody)["items"] as List;

      ticket = Ticket.fromJson(resBody);

      // print(tickets[0]);
    } else {
      print(res.reasonPhrase);
    }
    return ticket;
  }

  Future<int> create(Ticket ticket) async {
    int createdTicketId = 0;
    var headersList = {
      'Authorization': 'Bearer ${this.jwtKey}',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$API_URL/api/Tickets');

    var body = {
      "ticketCreateDto": {
        "supporteeEmail": ticket.supporteeEmail,
        "clientId": ticket.clientId,
        "branchId": ticket.branchId,
        "solutionId": ticket.solutionId,
        "subject": ticket.subject,
        "description": ticket.description,
        "status": ticket.status,
        "priority": ticket.priority,
        "ticketAssignmentsId": ticket.ticketAssignmentsId,
        "contactPerName": ticket.contactPerName,
        "contactPerMobile": ticket.contactPerMobile,
        "contactPerEmail": ticket.contactPerEmail,
        "contactPerPhone": ticket.contactPerPhone
      }
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (resBody.isNotEmpty) {
        createdTicketId = resBody as int;
      }
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }

    return createdTicketId;
  }

  Future<String> deleteTicket(int ticketId) async {
    String msg = "";
    var headersList = {
      'Authorization': 'Bearer ${this.jwtKey}',
      // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InJhc21peWEudGVjaCIsIk5hbWUiOiJSYXNtaXlhIE5hamVlbSIsIlVzZXJuYW1lIjoicmFzbWl5YS50ZWNoIiwiVXNlcklkIjoicmFzbWl5YS50ZWNoQGZsb3JhZ3JvdXAubmV0IiwiTWVtYmVyT2YiOiJDTj1Qcm9qZWN0IERlcGFydG1lbnQsREM9ZmxvcmFncm91cCxEQz1uZXQiLCJqdGkiOiIzOWE2MTVkNC05ODdiLTRkYjAtOGM0OC1jMDFjYzU2NjkxZDgiLCJuYmYiOjE3MTM2ODUzMDcsImV4cCI6MTcxMzY5MjUwNywiaWF0IjoxNzEzNjg1MzA3fQ.sYKCiZRDEZakyZcqd4AsvZr0y_xkWl1qEevPGk9WQi0',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$API_URL/api/Tickets/$ticketId');

    var req = http.Request('DELETE', url);
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

  // updateTicketStatus(int status) {
  //   var headersList = {
  //     'Authorization': 'Bearer ${this.jwtKey}',
  //     // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InJhc21peWEudGVjaCIsIk5hbWUiOiJSYXNtaXlhIE5hamVlbSIsIlVzZXJuYW1lIjoicmFzbWl5YS50ZWNoIiwiVXNlcklkIjoicmFzbWl5YS50ZWNoQGZsb3JhZ3JvdXAubmV0IiwiTWVtYmVyT2YiOiJDTj1Qcm9qZWN0IERlcGFydG1lbnQsREM9ZmxvcmFncm91cCxEQz1uZXQiLCJqdGkiOiIzOWE2MTVkNC05ODdiLTRkYjAtOGM0OC1jMDFjYzU2NjkxZDgiLCJuYmYiOjE3MTM2ODUzMDcsImV4cCI6MTcxMzY5MjUwNywiaWF0IjoxNzEzNjg1MzA3fQ.sYKCiZRDEZakyZcqd4AsvZr0y_xkWl1qEevPGk9WQi0',
  //     'Content-Type': 'application/json'
  //   };
  //   var url = Uri.parse('$API_URL/api/Tickets');
  // }

  Future<int> updateTicket(id, path, value) async {
    int updatedTicketId = 0;
    var headersList = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwtKey'
    };
    var url = Uri.parse('$API_URL/api/Tickets/PatchTicket/$id');

    var body = [
      {"path": path, "op": "replace", "value": value}
    ];

    var req = http.Request('PATCH', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      updatedTicketId = json.decode(resBody);
    } else {
      print(res.reasonPhrase);
    }
    return updatedTicketId;
  }

  Future<int> updateTicketStatus(int ticketId, int ticketStatus) async {
    int updatedTicketId = 0;
    var headersList = {
      'Authorization': 'Bearer $jwtKey',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$API_URL/api/Tickets/UpdateTicketStatus');

    var body = {"ticketId": ticketId, "newTicketStatus": ticketStatus};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      updatedTicketId = json.decode(resBody);
    } else {
      print(res.reasonPhrase);
    }
    return updatedTicketId;
  }

  Future<bool> uploadCommentDocument(File file, int commentId) async {
    bool uploaded = false;
    var headersList = {'Authorization': 'Bearer ${this.jwtKey}'};
    var url =
        Uri.parse('$API_URL/api/Tickets/UploadCommentDocument/$commentId');

    var body = <String, String>{};

    var req = http.MultipartRequest('POST', url);
    req.headers.addAll(headersList);
    req.files.add(await http.MultipartFile.fromPath('', file.path));
    req.fields.addAll(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      uploaded = true;
    } else {
      print(res.reasonPhrase);
    }
    return uploaded;
  }

  Future<int> gettAllrelatedTickets() async {
    int ticketCount = 0;
    var headersList = {
      'Authorization': 'Bearer ${this.jwtKey}',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$API_URL/api/Tickets/listAllUserRelatedTickets');

    var body = {"pageNumber": 0, "pageSize": -1};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);

      ticketCount = Ticket.toList(json.decode(resBody)).length;
    } else {
      print(res.reasonPhrase);
    }
    return ticketCount;
  }
}
