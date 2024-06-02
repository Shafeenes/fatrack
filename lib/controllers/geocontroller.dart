// import 'dart:ffi';

import 'dart:convert';

import 'package:fatracker/models/geo.dart';
import 'package:fatracker/models/ticket.dart';
import 'package:fatracker/constant/api_consts.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;

class GeoController {
  String jwtKey;
  GeoController({required this.jwtKey});

  // Future<List<Ticket>> getAllTickets() async {
  //   List<Ticket> tickets = [];
  //   var headersList = {
  //     'Authorization': 'Bearer ${this.jwtKey}',
  //     'Content-Type': 'application/json'
  //   };
  //   var url = Uri.parse('$API_URL/api/Tickets/listAllAssignedToUser');

  //   var body = {"pageNumber": 0, "pageSize": 100};

  //   var req = http.Request('POST', url);
  //   req.headers.addAll(headersList);
  //   req.body = json.encode(body);

  //   var res = await req.send();
  //   final resBody = await res.stream.bytesToString();

  //   if (res.statusCode >= 200 && res.statusCode < 300) {
  //     print(resBody);
  //     tickets
  //         .addAll(Ticket.toList(json.decode(res.stream.toString())["items"]));
  //     // tickets.addAll(Ticket.toList(json.decode(resBody)["items"]));
  //   } else {
  //     print(res.reasonPhrase);
  //   }

  //   return tickets;
  // }

  Future<String> create(Geo geo) async {
    String createdGeoUUID = "";

    var headersList = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${this.jwtKey}',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse(API_URL + '/api/Geo');

    var body = {
      geo.toJson(geo),
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      createdGeoUUID = jsonDecode(resBody);
    } else {
      print(res.reasonPhrase);
    }
    return createdGeoUUID;
  }

  // Future<String> deleteTicket(int ticketId) async {
  //   String msg = "";
  //   var headersList = {
  //     'Authorization': 'Bearer ${this.jwtKey}',
  //     // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InJhc21peWEudGVjaCIsIk5hbWUiOiJSYXNtaXlhIE5hamVlbSIsIlVzZXJuYW1lIjoicmFzbWl5YS50ZWNoIiwiVXNlcklkIjoicmFzbWl5YS50ZWNoQGZsb3JhZ3JvdXAubmV0IiwiTWVtYmVyT2YiOiJDTj1Qcm9qZWN0IERlcGFydG1lbnQsREM9ZmxvcmFncm91cCxEQz1uZXQiLCJqdGkiOiIzOWE2MTVkNC05ODdiLTRkYjAtOGM0OC1jMDFjYzU2NjkxZDgiLCJuYmYiOjE3MTM2ODUzMDcsImV4cCI6MTcxMzY5MjUwNywiaWF0IjoxNzEzNjg1MzA3fQ.sYKCiZRDEZakyZcqd4AsvZr0y_xkWl1qEevPGk9WQi0',
  //     'Content-Type': 'application/json'
  //   };
  //   var url = Uri.parse('$API_URL/api/Tickets/$ticketId');

  //   var req = http.Request('DELETE', url);
  //   req.headers.addAll(headersList);

  //   var res = await req.send();
  //   final resBody = await res.stream.bytesToString();

  //   if (res.statusCode >= 200 && res.statusCode < 300) {
  //     if (resBody.isNotEmpty) {
  //       msg = resBody;
  //     }
  //     print(resBody);
  //   } else {
  //     print(res.reasonPhrase);
  //   }

  //   return msg;
  // }

  // updateTicketStatus(int status) {
  //   var headersList = {
  //     'Authorization': 'Bearer ${this.jwtKey}',
  //     // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InJhc21peWEudGVjaCIsIk5hbWUiOiJSYXNtaXlhIE5hamVlbSIsIlVzZXJuYW1lIjoicmFzbWl5YS50ZWNoIiwiVXNlcklkIjoicmFzbWl5YS50ZWNoQGZsb3JhZ3JvdXAubmV0IiwiTWVtYmVyT2YiOiJDTj1Qcm9qZWN0IERlcGFydG1lbnQsREM9ZmxvcmFncm91cCxEQz1uZXQiLCJqdGkiOiIzOWE2MTVkNC05ODdiLTRkYjAtOGM0OC1jMDFjYzU2NjkxZDgiLCJuYmYiOjE3MTM2ODUzMDcsImV4cCI6MTcxMzY5MjUwNywiaWF0IjoxNzEzNjg1MzA3fQ.sYKCiZRDEZakyZcqd4AsvZr0y_xkWl1qEevPGk9WQi0',
  //     'Content-Type': 'application/json'
  //   };
  //   var url = Uri.parse('$API_URL/api/Tickets');
  // }

  // Future<String> updateTicket(Ticket ticket) async {
  //   String msg = "";
  //   var headersList = {
  //     'Authorization': 'Bearer ${this.jwtKey}',
  //     // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InJhc21peWEudGVjaCIsIk5hbWUiOiJSYXNtaXlhIE5hamVlbSIsIlVzZXJuYW1lIjoicmFzbWl5YS50ZWNoIiwiVXNlcklkIjoicmFzbWl5YS50ZWNoQGZsb3JhZ3JvdXAubmV0IiwiTWVtYmVyT2YiOiJDTj1Qcm9qZWN0IERlcGFydG1lbnQsREM9ZmxvcmFncm91cCxEQz1uZXQiLCJqdGkiOiIzOWE2MTVkNC05ODdiLTRkYjAtOGM0OC1jMDFjYzU2NjkxZDgiLCJuYmYiOjE3MTM2ODUzMDcsImV4cCI6MTcxMzY5MjUwNywiaWF0IjoxNzEzNjg1MzA3fQ.sYKCiZRDEZakyZcqd4AsvZr0y_xkWl1qEevPGk9WQi0',
  //     'Content-Type': 'application/json'
  //   };
  //   var url = Uri.parse('$API_URL/api/Tickets');

  //   var req = http.Request('PUT', url);
  //   req.headers.addAll(headersList);
  //   req.body = json.encode({
  //     "ticketUpdateDto": {
  //       "supporteeEmail": ticket.supporteeEmail,
  //       "clientId": ticket.clientId,
  //       "branchId": ticket.branchId,
  //       "solutionId": ticket.solutionId,
  //       "subject": ticket.subject,
  //       "description": ticket.description,
  //       "status": ticket.status,
  //       "priority": ticket.priority,
  //       "ticketAssignmentsId": ticket.ticketAssignmentsId,
  //       "contactPerName": ticket.contactPerName,
  //       "contactPerMobile": ticket.contactPerMobile,
  //       "contactPerEmail": ticket.contactPerEmail,
  //       "contactPerPhone": ticket.contactPerPhone,
  //       "id": ticket.id
  //     }
  //   });

  //   var res = await req.send();
  //   final resBody = await res.stream.bytesToString();

  //   if (res.statusCode >= 200 && res.statusCode < 300) {
  //     if (resBody.isNotEmpty) {
  //       msg = resBody;
  //     }
  //     print(resBody);
  //   } else {
  //     print(res.reasonPhrase);
  //   }

  //   return msg;
  // }
}
