import 'dart:convert';

import 'package:fatracker/enums/priority.dart';
import 'package:fatracker/enums/ticketstatus.dart';
import 'package:fatracker/models/assignee.dart';
import 'package:fatracker/models/branch.dart';
import 'package:fatracker/models/claim.dart';
import 'package:fatracker/models/client.dart';
import 'package:fatracker/models/solution.dart';
import 'package:fatracker/models/document.dart';
import 'package:fatracker/models/subject.dart';
import 'package:fatracker/utils/esc_html_attr.dart';

class Ticket {
  int id;
  Client client;
  Branch branch;
  Solution solution;
  List<Document> documents;
  Assignee currentAssignee;
  String created;
  String createdBy;
  String lastModified;
  String lastModifiedBy;
  String supporteeEmail;
  int clientId;
  int branchId;
  int solutionId;
  String subject;
  String description;
  int status;
  int priority;
  int ticketAssignmentsId;
  String contactPerName;
  String contactPerMobile;
  String contactPerEmail;
  String contactPerPhone;

  Ticket({
    this.id = 0,
    required this.client,
    required this.branch,
    required this.solution,
    required this.documents,
    required this.currentAssignee,
    required this.created,
    required this.createdBy,
    required this.lastModified,
    required this.lastModifiedBy,
    required this.supporteeEmail,
    required this.clientId,
    required this.branchId,
    required this.solutionId,
    required this.subject,
    required this.description,
    required this.status,
    required this.priority,
    required this.ticketAssignmentsId,
    required this.contactPerName,
    required this.contactPerMobile,
    required this.contactPerEmail,
    required this.contactPerPhone,
  });

  static Ticket fromJson(dynamic json) {
    String statusTxt = "";
    String priorityTxt = "";
    List docList = [];
    // if (json["documents"] == null) {
    //   docList = json["documents"] as List;
    //   if (docList.length == 0) {
    //     json["documents"] = List.empty();
    //   }
    // }
    // json["documents"] as List;

    // if (json["documents"] == [] )||
    //     // Document.toList(json["documents"]).length == 0) {
    //   json["documents"] = List.empty();
    // }

    var documents = json["documents"];
    // if (documents.isEmpty) {
    // documents = [];
    // }
    // if (documents.isEmpty) {

    // }

    switch (json["status"] as int) {
      case 1:
        statusTxt = "Low";
        break;
      case 2:
        statusTxt = "Medium";
        break;
      case 3:
        statusTxt = "High";
        break;
      default:
        statusTxt = "N/A";
        break;
    }

    switch (json["priority"] as int) {
      case 1:
        statusTxt = "Open";
        break;
      case 2:
        statusTxt = "Assigned";
        break;
      case 3:
        statusTxt = "Waiting for reply";
        break;
      case 4:
        statusTxt = "Solved";
        break;
      case 5:
        statusTxt = "Closed";
        break;
      default:
        statusTxt = "Not set";
        break;
    }

    return Ticket(
      id: json["id"],
      client: Client.fromJson(json["client"]),
      branch: Branch.fromJson(json["branch"]),
      solution: Solution.fromJson(json["solution"]),
      documents: Document.toList(json["documents"]),
      currentAssignee: Assignee.fromJson(json["currentAssignee"]),
      created: json["created"],
      createdBy: json["createdBy"],
      lastModified: json["lastModified"],
      lastModifiedBy: json["lastModifiedBy"],
      supporteeEmail: json["supporteeEmail"],
      clientId: json["clientId"],
      branchId: json["branchId"],
      solutionId: json["solutionId"],
      subject: json["subject"],
      description: EscHtmlAttr(htmlstr: json["description"]).getConvertedHtml(),
      status: json["status"],
      priority: json["priority"],
      ticketAssignmentsId: json["ticketAssignmentsId"],
      contactPerName: json["contactPerName"],
      contactPerMobile: json["contactPerMobile"],
      contactPerEmail: json["contactPerEmail"],
      contactPerPhone: json["contactPerPhone"],
    );
  }

  static Map<String, dynamic> toJson(Ticket ticket) {
    Map<String, dynamic> ticketJson = {};

    ticketJson["id"] = ticket.id;
    ticketJson["client"] = ticket.client.toJson(ticket.client);
    ticketJson["branch"] = ticket.branch.toJson(ticket.branch);
    ticketJson["solution"] = ticket.solution.toJson(ticket.solution);
    ticketJson["documents"] = Document.toJson(ticket.documents[0]);
    ticketJson["currentAssignee"] = ticket.currentAssignee;
    ticketJson["created"] = ticket.created;
    ticketJson["createdBy"] = ticket.createdBy;
    ticketJson["lastModified"] = ticket.lastModified;
    ticketJson["lastModifiedBy"] = ticket.lastModifiedBy;
    ticketJson["supporteeEmail"] = ticket.supporteeEmail;
    ticketJson["clientId"] = ticket.clientId;
    ticketJson["branchId"] = ticket.branchId;
    ticketJson["solutionId"] = ticket.solutionId;
    ticketJson["subject"] = ticket.subject;
    ticketJson["description"] = ticket.description;
    ticketJson["status"] = ticket.status;
    ticketJson["priority"] = ticket.priority;
    ticketJson["ticketAssignmentsId"] = ticket.ticketAssignmentsId;
    ticketJson["contactPerName"] = ticket.contactPerName;
    ticketJson["contactPerMobile"] = ticket.contactPerMobile;
    ticketJson["contactPerEmail"] = ticket.contactPerEmail;
    ticketJson["contactPerPhone"] = ticket.contactPerPhone;

    return ticketJson;
  }

  static List<Ticket> toList(List ticketsJson) {
    List<Ticket> tickets = [];
    ticketsJson.forEach((element) {
      var ticketEle = fromJson(element);
      tickets.add(ticketEle);
    });
    return tickets;
  }
}
